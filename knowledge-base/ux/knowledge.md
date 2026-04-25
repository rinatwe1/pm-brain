# UX Knowledge Base
## Pre-loaded Frameworks

---

### Krug's First Law of Usability — Don't Make Me Think (Steve Krug)
**What it is:** The foundational principle that a product should be self-evident — a person of average ability should be able to figure out how to accomplish their goal without the experience feeling like more effort than it's worth. "Self-evident" is a higher bar than "learnable." It means the right thing to do next should be obvious without thought, not just discoverable with effort.
**Core insight:** The problem with interfaces that require thought is not that users can't figure them out — they often can. The problem is the erosion of trust that happens every time a user has to stop and wonder "is this right?" or "what does this do?" Each moment of friction is a small withdrawal from the trust account, and enough small withdrawals produce a user who decides the product isn't worth their time.
**PM use case:** Use as the test for any UX decision that's in debate. Ask: "Would a person of average ability, opening this screen for the first time, know what to do without reading anything?" If the answer is no, it fails Krug's First Law. Use in design reviews, usability test debrief sessions, and when evaluating incoming feature requests that add complexity.

---

### Scanning Behavior and Satisficing — Don't Make Me Think (Steve Krug)
**What it is:** A descriptive model of how real users actually interact with interfaces. Users scan screens looking for keywords and visual cues that match their current goal — they don't read linearly. When they find something that looks approximately right, they click it rather than reading further to confirm it's the best option. This "good enough" decision-making under time pressure is called satisficing.
**Core insight:** The implication for design is that the visual hierarchy of a screen determines how it's used more than the quality of its content. A page with well-written copy buried in dense paragraphs will be used worse than a page with mediocre copy organized with clear headings, bullets, and visual weight. Design is visual organization first, content second.
**PM use case:** Use in design reviews and copywriting decisions. The test: "What does this screen look like to someone scanning for three seconds?" This is a different question than "Is this screen well-designed?" and usually produces more actionable feedback. Also use it to push back on copy-heavy designs — prose on a screen is almost never fully read.

---

### Billboard Design Principles — Don't Make Me Think (Steve Krug)
**What it is:** A set of organizing principles for visual design borrowed from the constraints of outdoor advertising. A billboard must communicate its message in the two seconds someone passes it at speed. Applied to screens, the principles are: clear visual hierarchy (the most important thing stands out), unambiguous affordances (clickable things look clickable, non-clickable things don't), minimal noise (nothing on the screen without a job to do), and a single dominant action (the primary call to action is unmistakable).
**Core insight:** Most screens fail billboard design because they were designed by committee, optimized for comprehensiveness rather than clarity, and never reviewed from the perspective of a user who doesn't know what they're looking at. Every element added to a screen that doesn't need to be there takes visual weight away from the elements that do. The discipline of removing is harder than the discipline of adding.
**PM use case:** Use during design reviews and stakeholder feedback sessions to give concrete language to vague usability concerns. "This violates billboard design — there are three things competing for the user's attention and none of them clearly wins" is more actionable than "it feels cluttered."

---

### The UX Design Iceberg — Lean Product Playbook (Dan Olsen)
**What it is:** A layered model of UX quality that maps the different levels of design work from the visible surface to the invisible foundation. At the top (visible): visual design — colors, typography, spacing, aesthetics. Below that: interaction design — the behaviors, transitions, and states of the interface. Below that: information architecture — how content and features are organized and navigated. At the base (invisible): conceptual design — the mental model the product asks users to adopt.
**Core insight:** Most product teams invest primarily at the top two layers (visual and interaction) because those are the most visible and the most easily evaluated by non-designers. But the layers at the bottom of the iceberg determine whether the layers on top work. A visually polished interface organized around a broken conceptual model still fails. The common failure is building top-down aesthetically while ignoring bottom-up architecture — which produces a product that looks good in screenshots but confuses users in practice.
**PM use case:** Use to diagnose recurring usability problems that persist despite repeated visual redesigns. When users keep making the same navigation errors or can't find the same features despite multiple UX iterations, the problem is usually below the visual layer — it's an IA or conceptual design issue that cosmetic changes can't fix.

---

### Value Proposition Canvas as a UX Framework — Value Proposition Design (Osterwalder et al.)
**What it is:** A translation of the Value Proposition Canvas (a strategy tool) into a UX design lens. The customer profile — jobs (what users are trying to accomplish), pains (frustrations, risks, and blockers in that process), and gains (desired outcomes and benefits) — becomes the design brief. Every UX decision is evaluated against this profile: does this feature relieve a pain that customers ranked as high priority? Does this flow help users complete the job they hired the product for?
**Core insight:** Most UX decisions are made based on what is technically feasible, what the team thinks is a good idea, or what stakeholders requested. The VPC-as-UX-framework redirects design decisions toward what customers actually care about. A feature that's elegant to use but doesn't address any job or pain in the customer profile is noise — beautiful, polished noise.
**PM use case:** Use at the start of a feature design cycle to align the team on the customer context before any wireframe is drawn. Use after design completion to audit whether the resulting experience actually addresses the jobs and pains it was meant to address. Use in design reviews when stakeholders push for features or flows that aren't grounded in the customer profile — ask which job or pain the proposal relieves.
