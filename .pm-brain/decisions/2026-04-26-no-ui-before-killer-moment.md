---
type: decision
domain: strategy
date: 2026-04-26
status: active
---

# Decision: אין UI עד שיש killer moment מאומת ב-CLI

**Date:** 2026-04-26  
**Domain:** strategy  
**Status:** active

## Decision
לא לבנות UI לפני שמשתמש אחד חווה "Claude הציל אותי מטעות" בCLI.

## Context
שאלה אסטרטגית: האם לבנות web interface שיציג decisions timeline + hypothesis engine + "you are repeating yourself"? ה-UI מספק leverage על competitors, אבל גם שובר את ה-positioning של "Claude Code native".

## Alternatives Considered
1. **UI מוקדם (Phase 2)** — leverage ויזואלי, קל למכור, שבוע עבודה עם Lovable. אבל: context switch, שובר positioning, ממוקד ב-nice-to-have לפני PMF.
2. **אין UI בכלל** — consistent עם positioning, אבל יגביל adoption בטווח הארוך.
3. **UI רק אחרי validation ב-CLI (נבחר)** — killer moment קודם, UI רק אם הוא משרת ולא מחליף.

## Reasoning
אם לא ניתן לגרום למשתמש לחוות פעם אחת "Claude הציל אותי מטעות" ב-CLI — גם UI יפה לא יעזור. UI כ-shortcut לPMF הוא אשליה. ICP הנוכחי (technical PMs) לא צריך UI — markdown מספיק.

## Trade-offs Accepted
Slower adoption. אנשים שלא טכניים לא יכלו להשתמש. Less impressive for demos.

## Success Signal
משתמש אומר "זה חסך לי טעות" בתגובה לhit ב-decision history — ב-CLI בלבד. לאחר מכן: UI planning יתחיל.

## Supersedes
none

## Source
_docs/ui-and-positioning.md (2026-04-26)
