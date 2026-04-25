# Roadmap Rules — Apply by Default

## Confirmed Rules
These are validated across many products and teams. Apply unless you have contradicting evidence.

---

### Rule: Commit to outcomes in the roadmap, not to specific solutions
**Source:** INSPIRED — Marty Cagan; Escaping the Build Trap — Melissa Perri
**The principle:** A roadmap that lists features pre-commits the team to solutions before discovery has been done. A roadmap that lists outcomes gives teams the freedom to discover better solutions while still communicating priorities to stakeholders.
**Why it works:** When a feature is on the roadmap, it becomes politically difficult to remove even after discovery reveals it won't solve the underlying problem. The feature was promised, expected, and planned around. Outcome commitments are much more durable: the goal remains stable while the specific solution can evolve as the team learns. They also provide a principled filter for evaluating stakeholder feature requests — any request can be evaluated against "does this achieve the outcome we've committed to?"
**How to apply:** Rewrite roadmap items from feature descriptions ("build notification center") to outcome descriptions ("reduce the rate at which active users miss time-sensitive events"). For each outcome, leave the solution space open until the team has done sufficient discovery.
**Exception:** When the team has already done thorough discovery and has high confidence in a specific solution — one that has been tested, not merely assumed. In this case, specifying the feature on the roadmap is acceptable, but it should be flagged as "validated solution" rather than "planned feature."

---

### Rule: Every roadmap item must have a stated goal and a measurable success criterion
**Source:** Strategize — Roman Pichler; OKRs Done Right — Itamar Gilad
**The principle:** Without a goal, you can't prioritize. Without a success metric, you can't know if it worked. Items without both are not product decisions — they're opinions about what to build next.
**Why it works:** The absence of explicit goals and metrics is what creates the build trap at the roadmap level. Teams build what's asked, without a clear picture of what success looks like, and without a mechanism for learning whether what they shipped mattered. Adding a goal and metric to each roadmap item forces the team to think through the reasoning before committing: why this item, why now, and how will we know it worked?
**How to apply:** For each roadmap item, require two things before it's added: (1) the outcome we expect this to produce, expressed as a change in user behavior or business metric, and (2) the specific metric we'll use to evaluate whether it worked. Items that can't be articulated in these terms are not ready for the roadmap.
**Exception:** Compliance requirements, security work, and legal obligations often cannot be tied to business metrics. For these, use milestone completion as the metric and document the risk-mitigation rationale as the goal.

---

### Rule: Treat the roadmap as a living document — review and update at minimum every quarter
**Source:** Strategize — Roman Pichler
**The principle:** A roadmap is a product of assumptions. As those assumptions are tested by reality — through experiments, customer feedback, market changes — the roadmap should change. A roadmap that doesn't change is not a tool; it's a plan, and plans don't survive contact with evidence.
**Why it works:** Teams that treat the roadmap as a fixed plan resist changing it because changing it feels like failure or broken commitment. This leads to teams executing on a plan they know is wrong because the organizational cost of admitting the plan should change is too high. Quarterly reviews normalize change: the question isn't "did we deviate?" but "what did we learn, and how does that update our priorities?"
**How to apply:** Schedule a standing quarterly roadmap review. The review agenda: What have we shipped since the last review, and did it achieve the outcomes we expected? What new information has changed our understanding of the opportunity space? What should move up, move down, or be removed?
**Exception:** Highly stable core products in mature markets with well-understood customer needs may function on a semi-annual review cycle. Even then, maintain the ability to trigger an off-cycle review when a significant market event, competitive development, or strategic change occurs.

---

### Rule: Communicate outcomes to stakeholders separately from solutions
**Source:** INSPIRED — Marty Cagan
**The principle:** "What we're trying to achieve" and "what we're planning to build" are two different conversations with different audiences at different stages. Conflating them invites stakeholders to debate solutions before the problem is understood.
**Why it works:** When you share a feature roadmap with stakeholders before discovery is complete, you implicitly invite them to judge, modify, and commit to specific solutions. Sales teams start promising those features to customers. Leadership asks for status updates on specific items. The solution becomes a commitment before it's been validated. Sharing outcomes first keeps the conversation at the right level — stakeholders can engage with "is this the right goal?" which is a useful conversation, before "is this the right feature?" which is premature.
**How to apply:** Create two artifacts: an outcome roadmap (goals and metrics, shareable broadly) and a solution roadmap (specific features, shareable after discovery). Update them on different cadences and share them with different audiences for different purposes.
**Exception:** In very mature, well-understood product areas with pre-validated solutions, sharing both levels simultaneously is appropriate. The test: is the solution already validated or is it still a hypothesis?

---

### Rule: Concentrate bets — fewer simultaneous initiatives produce better results
**Source:** Escaping the Build Trap — Melissa Perri
**The principle:** A roadmap with fifteen major initiatives in flight simultaneously guarantees shallow progress across all of them. Focused roadmaps with fewer, bigger bets produce better outcomes and are easier to execute against.
**Why it works:** Teams split across many priorities move slowly on all of them, not quickly on any. The cognitive overhead of context-switching between many initiatives reduces the quality of thinking on each. Stakeholders use the breadth of the roadmap to protect "their" initiative from being deprioritized, which makes every reprioritization conversation a political fight. Fewer initiatives means faster progress, easier prioritization conversations, and clearer accountability.
**How to apply:** For each active initiative on the roadmap, ask: "If we removed this and focused those resources on one of the others, would we make faster progress toward our outcomes?" If the answer is yes, it's a candidate for deprioritization. The goal is a roadmap where every initiative is receiving enough focus to make real progress.
**Exception:** Portfolio-level roadmaps across many independent teams can have more total items — the rule applies at the individual team level, not the organizational portfolio. Each team should focus; the portfolio can be wide.
