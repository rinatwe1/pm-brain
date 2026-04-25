# UX Rules — Apply by Default

## Confirmed Rules
These are validated across many products and teams. Apply unless you have contradicting evidence.

---

### Rule: Design every screen for scanning, not reading
**Source:** Don't Make Me Think — Steve Krug
**The principle:** Users scan screens in search of the signal that matches their current intent. They skip prose, ignore instructions, and jump to what looks relevant. A design that assumes users will read carefully will be misused by nearly every user who encounters it.
**Why it works:** Users are satisficers under time pressure — they take the first reasonable option rather than searching exhaustively for the best one. Designing for actual user behavior means structuring screens so that the most important elements are visible in a scan: clear hierarchy, short text chunks, prominent actions, and visual differentiation between categories of information. This is not dumbing things down — it's respecting users' time.
**How to apply:** Review each screen and ask: "If a user spent five seconds on this and clicked away, what would they have seen?" The answer tells you what is visually prominent. If what's prominent isn't what matters most, the visual hierarchy is wrong. Use bold headings, short bullets, and prominent calls to action to design for the scanner, not the reader.
**Exception:** Content-first products (documentation, reading apps, newsletters) where sustained reading is the explicit purpose. Even there, good information architecture helps users find the sections they want to read before they commit to reading.

---

### Rule: Test with real users continuously, not just at launch
**Source:** Don't Make Me Think — Steve Krug
**The principle:** Usability problems found before launch cost far less to fix than usability problems found after launch. The minimum viable usability practice is structured testing with three to five real users on a regular cadence — not as a pre-launch gate, but as an ongoing habit.
**Why it works:** Every team has assumptions about how users will navigate their product, read their copy, and interpret their interface. These assumptions are wrong more often than the team believes. Continuous testing catches wrong assumptions early — when they're a wireframe that can be redrawn in an hour, not a shipped feature that requires a full redesign. Three to five users in a test reveal the majority of significant usability problems; you don't need large samples to find critical issues.
**How to apply:** Schedule a standing monthly usability session. Keep it lightweight — a moderated 30-minute session with one user per week, or a batch of five unmoderated remote tests per month. The key is regularity: insights from a consistent cadence compound. One-off pre-launch tests produce a spike of insight that fades.
**Exception:** Products with no user-facing interface (pure APIs, infrastructure products). For anything with a UI used by a human, continuous testing applies.

---

### Rule: Fix confusion before adding features
**Source:** Don't Make Me Think — Steve Krug
**The principle:** A new feature added on top of a confusing interface doesn't solve the confusion — it adds another layer to navigate. Users who can't figure out how to use the core product won't discover new features, no matter how useful those features are.
**Why it works:** Confusion creates anxiety, and anxious users adopt workarounds and disengage. Usability debt compounds: the longer a confusing pattern exists, the more users learn to work around it, the harder the fix becomes, and the more risk there is in changing it. The right sequence is always to understand and fix what's not working before adding complexity.
**How to apply:** Before any significant feature addition, conduct a usability audit of the existing experience. Flag the top three points where users hesitate, misclick, or fail to complete tasks. These should be prioritized above new features unless there is an explicit strategic reason to add scope first.
**Exception:** When a new feature fundamentally reimagines the information architecture in a way that resolves existing confusion as a side effect. This is rare — and when it does happen, the usability improvement should be the stated goal, not a hoped-for byproduct.

---

### Rule: Build UX from conceptual model down to visual design, not the reverse
**Source:** Lean Product Playbook — Dan Olsen
**The principle:** The correct sequence for UX design is: conceptual model (what is this thing and how does it work?) → information architecture (how is it organized?) → interaction design (how does it behave?) → visual design (how does it look?). Teams that start with visual design are building the roof before the foundation.
**Why it works:** Visual design applied to a broken conceptual model is still a broken conceptual model — it just looks better. Users who encounter a beautiful interface that doesn't match their mental model of how the task should work will be confused and frustrated in a more polished way. The hard work is getting the conceptual model right, and that work must happen before any visual design decisions are made.
**How to apply:** At the start of any significant UX initiative, run a conceptual design session: what mental model do users bring to this problem? What categories and relationships do they naturally think in? Only when the conceptual model is validated (through research, not assumption) should information architecture and interaction patterns be designed.
**Exception:** Very early exploratory prototyping, where rough visual mockups serve as a faster way to explore and communicate a concept than wire diagrams. The exception ends the moment you're testing with real users — at that point, build top-down.

---

### Rule: Reduce cognitive load relentlessly — remove words, steps, and decisions
**Source:** Don't Make Me Think — Steve Krug
**The principle:** Every word that doesn't contribute information, every step that doesn't get users closer to their goal, and every decision that doesn't need to be made yet is a tax on the user's attention. Cut until it breaks, then add back only what's essential.
**Why it works:** Cognitive load is finite and invisible. Users don't experience it as "this interface is too complex" — they experience it as "I'm confused" or "this is taking too long" or they just leave. The cumulative effect of many small pieces of unnecessary complexity is a product that feels harder to use than it is. Cutting ruthlessly — welcome text, redundant explanations, optional profile fields, decorative elements — makes every remaining element more legible.
**How to apply:** Apply the "remove it and see what breaks" test to every element of a screen. If removing it doesn't break a user's ability to complete their task, it should probably be removed. Pay particular attention to welcome text ("Welcome to [Product]!"), explanatory copy that restates what's already obvious from the UI, and multi-step flows that could be collapsed.
**Exception:** Complex professional or technical tools where expert users need access to advanced information that novices don't. Even there, progressive disclosure — showing the advanced information only when the user requests it — is almost always better than displaying it always.
