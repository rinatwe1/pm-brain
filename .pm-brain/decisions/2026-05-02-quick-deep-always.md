---
type: decision
domain: strategy
date: 2026-05-02
status: active
---

# Decision: Quick/Deep חל על כל paths — לא רק כשאין docs

**Date:** 2026-05-02
**Domain:** strategy
**Status:** active

## Decision
שאלת Quick/Deep מוצגת תמיד ב-brain-init — גם כשנמצאו docs קיימים — לא רק כשאין docs.

## Context
המבנה המקורי הניח שאם נמצאו docs, הם מכסים הכל ואפשר פשוט לקרוא אותם ולשאול "מה חסר" (max 3 שאלות). אבל docs יכולים להיות: ישנים, חלקיים, שטחיים, לא מעודכנים. אין דרך לדעת מראש מה איכותם.

## Alternatives Considered
1. **PATH A קורא docs + שואל רק מה חסר (המקורי)** — מהיר, אבל מניח איכות docs שאי אפשר לדעת.
2. **PATH A תמיד Deep** — עמוק מדי, גוזל זמן גם כשהdocs טובים.
3. **Quick/Deep תמיד (נבחר)** — המשתמש יודע טוב מClaude כמה הdocs שלו אמינים.

## Reasoning
המשתמש יודע אם ה-PRD שלו ישן משנה שעברה או נכתב השבוע. Claude לא יכול לדעת. לכן הבחירה צריכה להיות של המשתמש, לא של הskill.

## Trade-offs Accepted
עוד שאלה בflow (Quick or Deep?) לפני שמתחילים. מקובל — ההסבר ברור ומוצדק.

## Success Signal
משתמש עם docs חלקיים בוחר Deep ומקבל memory מלא יותר ממה שהיה מקבל ב-PATH A המקורי.

## Supersedes
PATH A הישן (docs found → auto-extract → max 3 questions, no mode choice)

## Source
usability audit T01 — 2026-05-02
