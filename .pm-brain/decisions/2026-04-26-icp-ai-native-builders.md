---
type: decision
domain: strategy
date: 2026-04-26
status: active
---

# Decision: ICP מצומצם ל-AI-native builders

**Date:** 2026-04-26  
**Domain:** strategy  
**Status:** active

## Decision
לכוון לAI-native builders שעובדים ב-Claude Code 2-3 שעות ביום, לא לPMs כלליים.

## Context
ה-ICP המקורי היה רחב: "PMs who use Claude Code". ניתוח מצביע על כך שמי שלא חש ב-context tax יומיומי לא יאמץ את הכלי.

## Alternatives Considered
1. **ICP רחב — כל PM שמשתמש ב-Claude Code** — TAM גדול יותר, אבל ללא PMF ברור. הכאב לא מספיק חד.
2. **ICP צר — AI-native builders (נבחר)** — TAM קטן יותר, אבל הכאב הוא daily reality, לא theoretical.
3. **Enterprise PMs** — אין להם את ה-setup הטכני (git clone, bash installer).

## Reasoning
אם נכוון רחב מדי — נאבד PMF מוקדם. ICP שמרגיש context tax בכל שיחה עם Claude הוא הלקוח שישלם ויסנגר. Technical PMs קטנים/בינוניים עם 0-5 אנשים בצוות.

## Trade-offs Accepted
TAM קטן יותר בטווח הקצר. PMs קלאסיים בארגון גדול לא יאמצו — לא ה-focus.

## Success Signal
3 משתמשים מתוך ICP מדויק שמשתמשים daily בתוך 60 יום מ-launch ציבורי.

## Supersedes
none

## Source
_docs/ui-and-positioning.md (2026-04-26)
