# Metrics Knowledge Base
## Pre-loaded Frameworks

---

### OKRs — Objectives and Key Results — OKRs Done Right (Itamar Gilad)
**What it is:** A goal-setting structure built from two components: an Objective (a qualitative, inspiring statement of where you want to go) paired with two to five Key Results (quantitative measures that define what it looks like when you've arrived). The framework is designed to align effort across a team or organization while preserving team autonomy over how to achieve the goal.
**Core insight:** The most common failure mode in OKR implementation is writing key results that measure output (what the team did) rather than outcome (what changed for customers or the business). Output KRs feel precise but contain a hidden assumption — that the activity will produce the desired impact — which almost always goes untested. The discipline of writing outcome KRs forces teams to confront what they're actually trying to change and to design the measurement system around that, not around their plan.
**PM use case:** Use when aligning a team around a quarterly goal, when presenting product priorities to leadership, or when you need a mechanism for honest progress reporting that doesn't devolve into feature status updates. Particularly useful for translating business goals into product-level actions and for making the chain of logic from business goal → product goal → feature visible and debatable.

---

### The GIST Framework — OKRs Done Right (Itamar Gilad)
**What it is:** A four-level planning hierarchy that prevents the common mistake of jumping from goals directly to implementation. The levels are: Goals (what we're trying to achieve, expressed as outcomes), Ideas (hypotheses about how to get there), Steps (small, testable increments for validating each idea), and Tasks (the actual execution work).
**Core insight:** Most planning processes skip directly from goals to tasks, bypassing the ideas and steps layers. This produces roadmaps full of features (tasks) that were never evaluated as hypotheses (ideas) or broken into validatable increments (steps). The GIST framework makes the reasoning chain between strategic intent and daily work explicit, and creates natural checkpoints where the team can ask "is this idea still worth pursuing given what we've learned?"
**PM use case:** Use when building a product roadmap from an OKR. The goal is already set; the question is how to get there. GIST structures the path from goal to execution without committing to a full solution before the assumptions are tested. Particularly valuable for communicating the "why" behind each feature to engineers and designers.

---

### Outputs, Outcomes, and Impacts — OKRs Done Right (Itamar Gilad)
**What it is:** A three-level model of measurement that helps teams understand what they're actually accountable for. Outputs are deliverables: the code written, the features shipped, the content published. Outcomes are changes in user behavior: activation rates, retention rates, frequency of use, task completion rates. Impacts are business results: revenue, market share, cost reduction, customer satisfaction at scale.
**Core insight:** Teams have direct control over outputs, partial influence over outcomes, and indirect influence over impacts. The temptation is to measure at the output level (because you control it) or the impact level (because it's what leadership cares about). The sweet spot is outcomes — close enough to the work to be responsive to team decisions, close enough to business results to be meaningful. Outcomes are also where the most interesting product learning happens.
**PM use case:** Use as a filter when reviewing a metrics plan or OKR draft. For each metric, ask: is this measuring what we did, what changed for users, or what changed for the business? A healthy metrics plan has a mix of all three, with outcomes at the center and outputs as leading indicators rather than goals.

---

### The PMF Survey Method — Hacking Growth (Sean Ellis, as cited by Ellis & Brown)
**What it is:** A single-question survey designed to measure whether a product has achieved a level of customer love strong enough to support growth investment. The question: "How would you feel if you could no longer use this product?" The response options range from "very disappointed" to "not disappointed." The key signal is the percentage who answer "very disappointed."
**Core insight:** Standard satisfaction surveys are poor predictors of retention and growth because satisfied users still churn when something better comes along. Loss aversion is a stronger predictor of stickiness. A user who would be "very disappointed" if the product disappeared has built the product into their life in a way that a "satisfied" user has not. The 40% threshold for "very disappointed" responses is a minimum viable bar for growth readiness — not a ceiling.
**PM use case:** Run before any significant growth investment. Also use it diagnostically: after collecting responses, analyze the "very disappointed" segment specifically. What do they use the product for? What would they replace it with? What made them feel this way? The answers shape both the growth strategy (acquire more users like these) and the product strategy (make more users feel this way).

---

### Retention as the Foundation Metric — Lean Product Playbook (Dan Olsen)
**What it is:** The principle that user retention — the rate at which acquired users continue using the product over time — is the single most diagnostic metric for product health. Retention captures whether the product delivers ongoing value, not just initial interest.
**Core insight:** Retention is the metric that all other metrics depend on. High acquisition with poor retention produces a graph that looks like growth until the math catches up. High activation with poor retention means users experience the aha moment but don't find lasting value. Strong referral without retention means new users arrive, churn, and tell others it wasn't for them. Retention is the foundation that makes every other growth lever work. Fix it first, optimize everything else second.
**PM use case:** Use as the anchor metric in any product health review. Track at multiple intervals (Day 1, Day 7, Day 30, and the interval relevant to your product's natural cadence). When debating what to work on next, start by asking "what is currently happening to users after they activate?" — the retention curve tells you whether the product is delivering sustained value or a one-time experience.
