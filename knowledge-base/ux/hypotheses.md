# UX Hypotheses — Starting Points

## Common Hypotheses to Test
These are patterns observed across many products. Validate or invalidate for your specific context.

---

- [ ] Hypothesis: Users are not reading the copy on our key screens — they are scanning and often missing critical information
  Confidence: very high (scanning is the universal default; sustained reading on screens is rare)
  Source: Scanning behavior model, Don't Make Me Think (Krug)
  Test method: Run a five-second test on your most important screen: show it to five people for five seconds, then hide it and ask them to describe what they saw and what they think they would do next. Compare their recall to what you intended them to notice. The gap between intended attention and actual attention is your scanning problem.

---

- [ ] Hypothesis: New users cannot explain what our product does within ten seconds of seeing the homepage or first screen
  Confidence: medium-high (most products overestimate their own clarity)
  Source: Self-evidence principle, Don't Make Me Think (Krug)
  Test method: Recruit five people who have never seen the product. Show them the homepage or first screen for ten seconds. Then ask: "What does this do? Who is it for? What would you do first?" If you get vague, confused, or wildly varied answers, the first screen fails the self-evidence test. This is a product and copy problem, not just a design problem.

---

- [ ] Hypothesis: Users are making errors on specific screens that we interpret as user mistakes but are actually UX failures
  Confidence: high (most user errors are design errors in disguise)
  Source: Affordance and hierarchy principles, Don't Make Me Think (Krug)
  Test method: Pull error logs, support tickets, and customer service requests. Group them by screen and action. The screens with the highest error concentration are the worst usability failures. Run a moderated usability test specifically on those screens to watch users encounter the problem in real time — the root cause will be obvious within three sessions.

---

- [ ] Hypothesis: Our UX was designed from visual layer down — and has conceptual model or information architecture problems that surface redesigns haven't fixed
  Confidence: medium (particularly common in products that have gone through multiple visual redesigns without usability improvement)
  Source: UX Design Iceberg, Lean Product Playbook (Olsen)
  Test method: Identify recurring usability complaints that have persisted across multiple redesigns. If the same problems reappear after visual refreshes, the problem is below the visual layer. Run a card sorting exercise with ten users to expose whether the information architecture matches user mental models. Run a first-click test on key navigation decisions.

---

- [ ] Hypothesis: Users cannot reliably distinguish interactive elements from non-interactive ones on our most-used screens
  Confidence: medium (false affordances are extremely common in modern flat design)
  Source: Billboard design principles, Don't Make Me Think (Krug)
  Test method: Analyze heatmaps on your top five most-visited screens. Look for click patterns on elements that aren't interactive (text that looks like it might be a link, images that appear clickable, labels that resemble buttons). Also look for interactive elements receiving no clicks. Both patterns signal affordance failure.

---

- [ ] Hypothesis: The UX decisions we made in the last quarter cannot be traced to specific customer jobs, pains, or gains
  Confidence: medium-high (most UX decisions are driven by stakeholder preference or internal assumptions rather than customer evidence)
  Source: Customer-profile-grounded design, Value Proposition Design (Osterwalder et al.)
  Test method: Audit the last five significant UX decisions made by the team. For each, ask: "What specific customer job does this support? What specific pain does this relieve? What specific gain does this create?" Decisions that can't be traced to any of these were designed from the inside out. Count how many of your last five fall into this category.
