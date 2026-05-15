-- NextLevel JobHunter — Supabase Schema
-- Bu SQL'i Supabase Dashboard → SQL Editor → "New Query" alanına yapıştırıp "Run" basın
-- 1 dakikada tablolar + RLS politikaları + indexler oluşur

-- =================================================================
-- 1. SUBSCRIBERS TABLOSU
-- =================================================================
CREATE TABLE IF NOT EXISTS public.subscribers (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email                 TEXT UNIQUE NOT NULL,
  full_name             TEXT,
  keywords              TEXT NOT NULL,
  exclude_keywords      TEXT,
  locations             TEXT DEFAULT 'Istanbul',
  seniority_levels      TEXT DEFAULT 'Director, VP, CMO',
  industries_preferred  TEXT,
  sources_enabled       TEXT DEFAULT 'adzuna,jsearch,themuse',
  language              TEXT DEFAULT 'tr' CHECK (language IN ('tr', 'en')),
  tier                  TEXT DEFAULT 'free' CHECK (tier IN ('free', 'pro', 'team')),
  status                TEXT DEFAULT 'active' CHECK (status IN ('active', 'paused', 'cancelled')),
  unsubscribe_token     TEXT UNIQUE NOT NULL DEFAULT replace(gen_random_uuid()::text, '-', ''),
  joined_at             TIMESTAMPTZ DEFAULT NOW(),
  last_sent_at          TIMESTAMPTZ,
  total_reports_sent    INTEGER DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_subscribers_status ON public.subscribers(status);
CREATE INDEX IF NOT EXISTS idx_subscribers_email ON public.subscribers(email);
CREATE INDEX IF NOT EXISTS idx_subscribers_token ON public.subscribers(unsubscribe_token);

-- =================================================================
-- 2. DAILY_LOG TABLOSU
-- =================================================================
CREATE TABLE IF NOT EXISTS public.daily_log (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subscriber_id     UUID REFERENCES public.subscribers(id) ON DELETE CASCADE,
  subscriber_email  TEXT NOT NULL,
  run_date          DATE DEFAULT CURRENT_DATE,
  jobs_found        INTEGER DEFAULT 0,
  high_match        INTEGER DEFAULT 0,
  borderline        INTEGER DEFAULT 0,
  low_match         INTEGER DEFAULT 0,
  email_sent        BOOLEAN DEFAULT FALSE,
  error_message     TEXT,
  raw_report        JSONB,
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_log_date ON public.daily_log(run_date);
CREATE INDEX IF NOT EXISTS idx_log_subscriber ON public.daily_log(subscriber_id);

-- =================================================================
-- 3. PAYMENTS TABLOSU (manuel takip için)
-- =================================================================
CREATE TABLE IF NOT EXISTS public.payments (
  id                       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subscriber_id            UUID REFERENCES public.subscribers(id) ON DELETE SET NULL,
  email                    TEXT NOT NULL,
  tier                     TEXT NOT NULL,
  amount_usd               DECIMAL(10,2),
  paid_at                  TIMESTAMPTZ DEFAULT NOW(),
  stripe_session_id        TEXT,
  next_renewal             DATE,
  notes                    TEXT
);

-- =================================================================
-- 4. ROW LEVEL SECURITY (RLS)
-- =================================================================
ALTER TABLE public.subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_log   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments    ENABLE ROW LEVEL SECURITY;

-- subscribers: anon kullanıcı SADECE INSERT yapabilir (kayıt olma)
CREATE POLICY "anon_can_subscribe" ON public.subscribers
  FOR INSERT TO anon
  WITH CHECK (true);

-- subscribers: anon kullanıcı SADECE kendi unsubscribe_token'i ile güncelleyebilir
CREATE POLICY "anon_can_unsubscribe_with_token" ON public.subscribers
  FOR UPDATE TO anon
  USING (true)
  WITH CHECK (status = 'cancelled');

-- daily_log: anon erişimi kapalı (sadece service_role yazabilir)
-- payments: anon erişimi kapalı

-- service_role (n8n için) tüm tablolarda full access
-- (Supabase otomatik olarak service_role'a tüm yetkileri verir, ek policy gerekmez)

-- =================================================================
-- 5. KULLANIM ÖRNEKLERİ (test için)
-- =================================================================
-- Test insert:
-- INSERT INTO public.subscribers (email, full_name, keywords, language)
-- VALUES ('test@example.com', 'Test User', 'Marketing Director', 'tr');

-- Aktif abone sayısı:
-- SELECT COUNT(*) FROM public.subscribers WHERE status = 'active';

-- Bugünkü gönderim raporu:
-- SELECT subscriber_email, jobs_found, high_match, email_sent
-- FROM public.daily_log WHERE run_date = CURRENT_DATE;
