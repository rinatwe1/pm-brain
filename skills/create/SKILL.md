---
name: create
description: Create a PRD through interactive conversation. Asks edge case questions and identifies NFRs.
allowed-tools: Read, Write, Edit, Glob, AskUserQuestion
---

# /create - PRD Creation Skill

Create a Product Requirements Document through interactive conversation.

---

## Usage

```
/create [product-name]
```

or

```
/create "[product description]"
```

**Examples:**
- `/create spirit`
- `/create "wellness platform for spiritual instructors"`
- `/create "mobile app for tracking habits"`

---

## Process

### Step 0: Check Project & Load Context

**CRITICAL: Always start here!**

1. **Check if product folder exists:**
   ```bash
   # Check if Work/[product]/ exists
   ```

2. **If product folder exists:**
   - Read `.product-os.yaml` from `Work/[product]/.product-os.yaml`
   - Check stage:
     - `discovery-complete` → Read insights! (best case)
     - `discovery` → Ask if they want to finish discovery first
     - `prd-created` → PRD already exists, ask if they want to update
   - Check if `research/insights.md` OR `02_Research/insights.md` exists → **Read it!**

3. **If insights.md exists:**
   ```
   ✅ מצאתי insights.md מהדיסקברי!

   אני אשתמש במחקר הזה כבסיס ל-PRD:
   - User personas
   - Pain points
   - Competitor analysis
   - Research findings

   זה יהפוך את השיחה להרבה יותר ממוקדת!

   בואי נמשיך לבנות את ה-PRD...
   ```

4. **If product folder doesn't exist:**
   - This is a new product
   - Will create `Work/[product]/` folder
   - Ask: "האם עשית discovery? יש לך research?"
   - Options:
     - "כן, יש research" → ask to import/organize
     - "לא" → suggest `/discover [product]` first (optional)
     - "בואי נדלג" → continue without research

---

### Step 1: Understand the Idea

**If insights.md was loaded:**
- You already know: problem, users, pain points
- Confirm understanding: "לפי המחקר, הבעיה העיקרית היא [X] ל-[users]. נכון?"
- Focus on: solution approach, MVP scope

**If no insights (new product or skipped discovery):**
- Ask clarifying questions:
  1. **What problem are we solving?** (Be specific)
  2. **Who is this for?** (Primary users)
  3. **What's the core value proposition?** (Why would they use it?)

**Output:** Clear understanding of the problem, users, and solution.

---

### Step 2: Ask Edge Case Questions

**Critical: Ask these in small batches (2-3 at a time), wait for answers, then dig deeper.**

**Don't dump 20 questions at once - this is a conversation!**

#### User Journey Edge Cases
- What if user tries to [core action] but [obstacle]?
- What if user starts [process] but doesn't finish?
- What if user wants to undo/cancel?
- What if user makes a mistake?

#### Payment & Transactions (if applicable)
- What if payment fails?
- What if user wants a refund?
- What if there's a dispute?
- What if pricing changes mid-transaction?

#### Multi-User Scenarios (if applicable)
- What if two users try to [action] at the same time?
- What if user A deletes something user B is using?
- What if permissions conflict?

#### Data & Content
- What if user uploads invalid data?
- What if content is inappropriate/violates policies?
- What if user tries to access deleted/archived data?
- What if user wants to export their data?

#### Technical Failures
- What if internet connection drops mid-action?
- What if server is down?
- What if third-party API fails?

#### Business Logic
- What if user exceeds limits (storage, usage, etc.)?
- What if subscription expires?
- What if trial period ends?

**Style:**
- Ask 2-3 questions
- Wait for answer
- Dig deeper: "Interesting! So if [scenario], then [follow-up question]?"
- Move to next set

**Output:** Comprehensive understanding of edge cases and how to handle them.

---

### Step 3: Identify Non-Functional Requirements (NFRs)

**Ask about each category:**

#### Performance
- How fast should pages load? (< 2s? < 1s?)
- How many concurrent users should we support?
- Any specific performance requirements?

#### Security
- What authentication method? (OAuth, email/password, SSO?)
- What data needs encryption?
- Any compliance requirements? (GDPR, HIPAA, etc.)
- How do we handle PII (Personally Identifiable Information)?

#### Accessibility
- WCAG compliance level? (AA? AAA?)
- Screen reader support needed?
- Keyboard navigation?
- Color contrast requirements?

#### Localization
- What languages? (Hebrew, English, both?)
- RTL (Right-to-Left) support needed?
- Date/time formats? (ISO, locale-specific?)
- Currency? (ILS, USD, both?)

#### Mobile
- Mobile-first? Responsive? Native app?
- What devices/screen sizes?
- Touch target sizes?
- Offline support?

#### Privacy
- How long do we keep user data?
- Can users delete their data?
- Do we share data with third parties?
- Cookie policy?

**Style:**
- Don't ask all at once
- Focus on relevant categories for this product
- Skip irrelevant ones (e.g., no need for payment NFRs if product is free)

**Output:** Complete NFR section.

---

### Step 4: Document User Flows

**Based on conversation, document:**

1. **Happy Path** - the main successful flow
2. **Edge Cases** - what if scenarios and how we handle them
3. **Error States** - what user sees when things go wrong

**Format:**
```
Happy Path: User books an event
1. User browses events
2. User selects event
3. User enters details
4. User pays
5. User receives confirmation

Edge Case: Payment fails
- What if: Credit card is declined
- Solution: Show error, allow retry with different card
- User experience: Clear error message + retry button
```

**Output:** Clear user flows section.

---

### Step 5: Define Success Metrics

**Ask:**
- What does success look like for this product?
- How do we measure success?
- What are the key metrics?

**Categories:**
- **Acquisition:** How many users?
- **Activation:** How many complete onboarding?
- **Engagement:** How often do they use it?
- **Retention:** How many come back?
- **Revenue:** How much money? (if applicable)
- **Referral:** How many invite others?

**Output:** Clear success metrics (3-5 key metrics).

---

### Step 6: Summarize & Confirm

**Before generating PRD:**
1. Summarize what you understood:
   - Problem & solution
   - Target users
   - Core features
   - Key edge cases
   - Critical NFRs
   - Success metrics

2. Ask: "האם אני מבין נכון? משהו חסר או צריך לשנות?"

3. Wait for confirmation

**Output:** Alignment before generating PRD.

---

### Step 7: Generate PRD

1. **Read template:**
   ```
   /Users/rinatweiss/Downloads/Work/_System/product-os/templates/prd-template.md
   ```

2. **Fill in all sections** based on conversation + insights.md (if exists)

3. **If insights.md exists:**
   - Use personas from insights
   - Reference pain points
   - Include competitive analysis summary
   - Link to research folder

4. **Save PRD:**
   ```
   /Users/rinatweiss/Downloads/Work/[product-name]/PRD.md
   ```

5. **Create/Update .product-os.yaml:**
   ```yaml
   name: [product-name]
   type: [pm-only or full-stack]
   owner: [user name]
   created: [date or keep existing]
   last_updated: [today]

   stage: prd-created
   status: needs-verification

   prd:
     created: [today]
     version: "0.1.0"

   files:
     - PRD.md
     - research/insights.md  # if exists

   next_action: "Run /verify [product] to validate PRD"
   ```

6. **Display PRD** to user

7. **Suggest next steps:**
   ```
   ✅ PRD נוצר ב-Work/[product-name]/PRD.md

   הצעד הבא:
   /verify [product-name] - לבדוק אם משהו חסר

   רוצה לראות את ה-PRD המלא?
   ```

**Output:** Complete PRD file + .product-os.yaml updated.

---

## Important Notes

### Conversation Style
- **Ping-pong, not interrogation**
  - Ask 2-3 questions at a time
  - Wait for answers
  - Dig deeper based on answers
  - Don't dump 20 questions at once

- **Be curious**
  - "אהה, מעניין! אז אם [scenario]?"
  - "ואיך זה עובד כשה-[edge case]?"
  - "עוד שאלה על זה..."

- **Be focused**
  - Don't go down rabbit holes
  - Keep the end goal in mind (PRD)
  - Skip irrelevant NFRs

### Edge Cases Are Key
- **Ask early** - they shape the product
- **Ask often** - there are always more edge cases
- **Ask "what if"** - this is your superpower

### NFRs Matter
- **Don't skip them** - they often make or break a product
- **Be specific** - "fast" is not a requirement, "< 2s" is
- **Ask relevant ones** - skip payment NFRs for free products

### Integration with /discover
- **Best practice:** Run `/discover [product]` first
- **If insights.md exists:** Use it! Don't ask redundant questions
- **Save time:** Research-backed PRD is faster and better

### Project Metadata Management
- **Always update .product-os.yaml** in project folder
- **Validate before saving:** check required fields present
- **Create folder if new project:** Work/[product]/

---

## Example Conversation Flow

**Scenario 1: With insights.md (after /discover)**

**User:** `/create spirit`

**Claude:**
```
✅ מצאתי את פרויקט Spirit ב-Work/Spirit/!

📊 **מה יש לנו:**
- ✅ Discovery הושלם (2026-02-11)
- ✅ insights.md קיים ב-02_Research/ עם:
  - 2 user personas (buyers + suppliers)
  - 5 pain points מנותחים
  - ניתוח מתחרים

זה מעולה! אני אשתמש במחקר הזה כבסיס ל-PRD.

לפי המחקר, הבעיה המרכזית היא שקשה למנחים רוחניים למצוא תלמידים
והם משתמשים ב-WhatsApp ואקסל לנהל הכל. נכון?

בואי נתחיל לבנות את ה-PRD.

**קודם כל - MVP Scope:**
1. מה בדיוק נכלול ב-MVP? (Discovery + Booking? Community? Content?)
2. מה אנחנו מחליטים להשאיר ל-V2?
```

**Scenario 2: Without research (new product)**

**User:** `/create "mobile app for tracking habits"`

**Claude:**
```
אוקי, בואי נבנה PRD לאפליקציית הרגלים! 🎯

לפני שמתחילים - **האם עשית discovery?** יש לך research על המשתמשים?
```

[User answers]

**Claude:**
```
קודם כל, בואי נבין את הבעיה:

1. **מה הבעיה שאנשים מתמודדים איתה?**
   - שוכחים לעשות הרגלים? קשה להתמיד? משהו אחר?

2. **מי קהל היעד הראשון?**
   - אנשים שמנסים לבנות הרגלים חדשים? לשבור ישנים?
```

[continues with full conversation]

---

## Success Criteria

✅ PRD created with all sections filled
✅ Edge cases documented
✅ NFRs identified
✅ User flows clear
✅ Success metrics defined
✅ .product-os.yaml updated in project folder
✅ User confirmed understanding
✅ insights.md used if available

---

**Created:** 11 February 2026
**Updated:** 15 February 2026 - v1.0.0 Architecture
**Status:** ✅ Updated for v1.0.0
