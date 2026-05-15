# KPI'lar ve Karar Çerçevesi

## Aşama 0 (Landing Page Validation) — 1 Hafta

### Birincil Sinyal

| Metrik | Kötü | İyi | Mükemmel | Ne Anlama Geliyor |
|--------|------|-----|----------|-------------------|
| Waitlist Conversion (ziyaret → kayıt) | <%3 | %5-10 | >%10 | Mesajların ne kadar tutarlı |
| Mutlak signup | <20 | 50-100 | >100 | Talep gerçek mi? |
| Kalitatif feedback | "ilginç" | "ben de istiyorum" | "ne zaman?" | Acil ihtiyaç var mı? |

### Yan Sinyal (kalitatif, sayılardan önemli)

- Tanımadığın insanlardan organik ulaşma var mı? (LinkedIn DM, email)
- "Bu fikri kim daha önce yaptı mı?" diye soran insanlar (= rekabet farkındalığı = pazar var)
- Eski iş arkadaşları "ben de istiyorum" diyenler (= problem gerçek)

### Anti-Sinyal (durdurma sebebi)

- 1 hafta sonunda <10 signup → kanaldan getirememişiz veya mesaj yanlış
- "Bunu yapıyorlar zaten" diyen 3+ kişi → rekabet kontrolü gerek (LinkedIn Recruiter, Glassdoor Pro)
- KVKK uyumluluğu konusunda hukuki danışmandan kırmızı bayrak

---

## Karar Ağacı

```
1 Hafta Sonu:
├─ 50+ signup + olumlu yorumlar
│   └─ Aşama 1 başla (MVP build, Next.js + Supabase)
├─ 20-49 signup
│   ├─ Mesajları iyileştir (örn. başlığı değiştir, sosyal kanıt ekle)
│   ├─ Yeni kanallarda dene (Reddit, Twitter)
│   └─ +1 hafta daha bekle
└─ <20 signup
    ├─ Pivot:
    │   ├─ Daha dar niş? (sadece pazarlama, sadece Türkiye, vb)
    │   ├─ Farklı ICP? (örn. kariyer koçları)
    │   └─ Farklı format? (haftalık digest yerine real-time alert)
    └─ Ya da durdur (sunk cost düşmesin)
```

---

## Aşama 1 (MVP Beta) — 2-3 Hafta

Hedef: 20 aktif kullanıcı, %30+ haftalık geri dönüş.

| Metrik | Hedef | Ölçüm Aracı |
|--------|-------|--------------|
| Toplam kayıt | 100+ | Supabase auth |
| 7 günlük aktif kullanıcı (WAU) | 30+ | Posthog |
| Haftalık geri dönüş (retention) | %30+ | Cohort analizi |
| Ortalama oturum süresi | 3+ dk | Posthog |
| "Aramayı çalıştır" tıklaması / kullanıcı / hafta | 2+ | Custom event |
| NPS (kullanıcı anketi) | 30+ | Manual survey |

---

## Aşama 2 (Paid Launch) — 4-8 Hafta

Hedef: İlk para ödeyen 10 müşteri.

| Metrik | Hedef | Anlamı |
|--------|-------|--------|
| Free → Pro conversion | %3-5 | İyi pazarlardaki tipik SaaS |
| Pro müşteri sayısı (1. ay) | 10 | MRR $90, küçük ama başlangıç |
| Churn rate | <%10/ay | İyi |
| Activation rate (kayıt → ilk arama) | %70+ | Onboarding iyi mi? |
| Time to first value (TTFV) | <5 dk | Hızlı değer hissi |

---

## Maliyet Modeli ve Birim Ekonomi

### Kullanıcı başına maliyet (haftada 3 arama varsayımı)

| Kalem | Birim Maliyet | Aylık (12 arama/ay) |
|-------|----------------|----------------------|
| Adzuna API | $0 (free tier) | $0 |
| JSearch API | $0.005/arama | $0.06 |
| Claude API (scoring) | ~$0.02/arama | $0.24 |
| Supabase (DB+Auth) | $0 (free tier <500MB) | $0 |
| Resend email | $0.001/email | $0.012 |
| **Toplam (free user)** | | **~$0.31/ay** |

### Pro ($9/ay) müşteri ekonomisi

- Sınırsız arama varsayımı: 100 arama/ay
- Marjinal maliyet: ~$2.60
- Gross margin: **$6.40/ay (~%71)** ← SaaS için sağlıklı

### Break-even

- Free user $0.31/ay yükler
- Pro user $9 - $2.60 = $6.40 net katkı
- **Free:Pro = 20:1 oranında dengeli** (20 free + 1 pro = $6.40 - 20*$0.31 = $0.20 kar)
- **Hedef:** %5+ Pro conversion → kâr eden bir SaaS

### Kritik nokta

Eğer her free user'a günde 1 arama hakkı verirsen, free maliyeti $2.40/ay'a fırlar — Pro conversion zorunlu. **3 arama/hafta limitini geçme** veya BYO (kullanıcı kendi API key'i) opsiyonu ekle.

---

## Pivot Sinyalleri

Bu sinyallerden 2+ varsa pivot/durdur düşün:

1. Waitlist conversion <%3 (mesaj rezone etmiyor)
2. MVP beta'da activation <%50 (onboarding berbat veya değer yok)
3. Beta kullanıcıların %50+'sı 2 hafta içinde dönmüyor (need yok)
4. Pro'ya geçenler <%2 (ödemeye değmiyor)
5. Churn rate >%20/ay (ürün stabilize değil)

---

## Karar Toplantısı Şablonu (haftalık 30 dk)

Her hafta cumartesi sabahları:

1. Bu haftaki rakamlar nedir? (5 dk)
2. Hangi feedback / şikayet geldi? (10 dk)
3. Beklediğimiz hedeflere ulaştık mı? (5 dk)
4. Sonraki hafta ne yapacağız? (10 dk)
   - Eğer hedefler iyi → yeni feature
   - Eğer hedefler düşük → mesaj iyileştirme veya pivot

---

**Not:** Bu çerçeve "fail fast, learn fast" yaklaşımına dayanır. 2-3 ay içinde ya çalışıyor olur ya da çalışmadığını anlarsın. İkisi de değerli — sunk cost'u ne kadar küçük tutarsan o kadar iyi.
