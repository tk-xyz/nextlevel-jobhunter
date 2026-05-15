# NextLevel Job Hunter

AI-powered executive job search tool that analyzes positions from LinkedIn, Indeed, Adzuna, The Muse and more — scoring each role against your career profile and delivering daily executive briefings.

**Stage:** Aşama 0 — Landing Page + Waitlist  
**Owner:** Tuğsan Koyuncu  
**Started:** 14 May 2026

## Vision

Mid-to-senior professionals waste hours every week filtering through irrelevant job listings. NextLevel uses AI to do that work for them — scoring each opportunity (0-10) against their actual seniority, industry, and career trajectory, then delivering a clean executive report.

## Pricing (planned)

- **Free:** 3 searches per week
- **Pro $9/month:** Unlimited searches, history, cover letter drafts, CV alignment suggestions
- **Team $29/month:** Multiple profiles, shared dashboards (future)

## Project Structure

```
NextLevel-JobHunter/
├── README.md                  This file
├── docs/                      Plans, research, architecture
│   ├── initial-plan.md       Original 10-section plan
│   ├── stage-0-landing.md    Waitlist strategy
│   └── kpi-plan.md           Success metrics
├── landing/                   Aşama 0 — public landing page
│   ├── index.html
│   ├── style.css
│   └── script.js
├── app/                       Aşama 1 — Next.js app (later)
├── workflows/                 n8n workflow JSONs
└── assets/                    Logos, screenshots
```

## Roadmap

- [ ] **Aşama 0 — Landing + Waitlist** (this week)
  - [x] Project structure
  - [ ] Landing page (TR + EN)
  - [ ] Waitlist form with Formspree
  - [ ] Deploy to Vercel/Netlify
  - [ ] Share on LinkedIn + measure signal
- [ ] **Aşama 1 — MVP** (1-2 weeks after 50+ signups)
  - [ ] Next.js + Supabase scaffold
  - [ ] Auth (Google login)
  - [ ] Search form + Adzuna + JSearch + The Muse integration
  - [ ] Claude scoring
  - [ ] Email + dashboard
- [ ] **Aşama 2 — Paid tier** (after 20+ active free users)
  - [ ] Stripe integration
  - [ ] Free/Pro tier limits
  - [ ] User onboarding flow

## Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-05-14 | Validate via waitlist before building | Avoid wasted dev if no demand |
| 2026-05-14 | Tech stack: Next.js + Supabase + n8n backend (after validation) | SaaS standard, low lock-in |
| 2026-05-14 | Pricing: Freemium 3 free/week, Pro $9/mo | Market test typical SaaS |
| 2026-05-14 | Email: Resend transactional (not user Gmail) | Required for multi-user product |

## Owner Tasks

- [ ] Pick a domain name (suggestions: nextleveljobhunter.com, careernavigator.ai, joblens.ai)
- [ ] Decide brand colors/logo style
- [ ] Set up Formspree account (free) for waitlist
- [ ] Open Vercel account for deployment
- [ ] Draft LinkedIn announcement post

## Notes

This is a **commercial** product targeting mid-to-senior professionals in Turkey and EMEA. KVKK/GDPR compliance required from day 1 (privacy policy, cookie consent, data deletion). LinkedIn ToS respected — we use JSearch (licensed aggregator), never scrape directly.
