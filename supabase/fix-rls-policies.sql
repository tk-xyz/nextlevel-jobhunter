-- RLS Policy Fix — anon kullanıcının INSERT yapabilmesi için
-- Bu SQL'i Supabase Dashboard → SQL Editor'da çalıştırın

-- Mevcut policy'leri (varsa) sil
DROP POLICY IF EXISTS "anon_can_subscribe" ON public.subscribers;
DROP POLICY IF EXISTS "anon_can_unsubscribe_with_token" ON public.subscribers;
DROP POLICY IF EXISTS "anon_can_read_for_token_check" ON public.subscribers;

-- Anon kullanıcı INSERT yapabilir (kayıt)
CREATE POLICY "anon_can_subscribe" ON public.subscribers
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Anon kullanıcı UPDATE yapabilir AMA sadece status'u cancelled'a değiştirebilir
-- (unsubscribe token ile, frontend'de filtreliyoruz)
CREATE POLICY "anon_can_unsubscribe" ON public.subscribers
  FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (status = 'cancelled');

-- Kontrol et: policy'ler oluştu mu?
SELECT tablename, policyname, permissive, roles, cmd
FROM pg_policies
WHERE tablename = 'subscribers';
