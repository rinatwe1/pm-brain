---
type: hypothesis
id: HYP-002
title: סריקת כל .pm-brain/ לlinking לא תייצר רעש בפרויקטים קטנים-בינוניים
date: 2026-05-01
category: technical
confidence: 6/10
status: unvalidated
expires: 2026-05-15
---

# HYP-002: Linking Scope Hypothesis

## Hypothesis
We believe that scanning all of `.pm-brain/` (decisions/ + hypotheses/ + knowledge/) for linking suggestions will produce relevant, not noisy, results for projects with <50 decisions and <40 hypotheses. We will measure by: ratio of relevant to irrelevant link suggestions in the first 10 synthesis runs.

## Test Method
Run /synthesize-meeting 10 times. Count suggested links. Rate each as relevant/irrelevant. If >30% irrelevant → invalidated.

## Definition of Validated
>70% of suggested links rated as relevant by the PM.

## Definition of Invalidated
>30% of suggested links are noise, or context window cost becomes noticeably slow.

## Validation Log

## Links
- Created during: brain-init
- See: T07 (linking scope review task)
- Related decision: linking scope set to all .pm-brain/ on 2026-05-01
