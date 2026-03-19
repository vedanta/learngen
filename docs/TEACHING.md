# Teaching Standard

These principles apply to every tutorial built with LearnGen, regardless of tech stack. All agents read and follow these rules.

---

## Code Principles

### Simplicity above all
- Write the simplest version that works. No clever tricks, no premature abstractions.
- One concept per file/function. Don't combine multiple new ideas in a single change.
- Use descriptive variable names — `fortuneList` over `fl`, `isLoading` over `ld`.
- Keep files short. If a file is getting long, split it — but only along clear boundaries.
- Prefer explicit code over abstractions — duplicating 3 lines is better than a premature helper function.

### One concept per stage
- Each stage introduces exactly ONE new idea. Never combine two new patterns in one stage.
- The code should read like a lesson — a beginner traces through it and learns that one concept.
- If a stage feels like it needs two new ideas, split it into two stages.

### Always a working app
- Every stage must produce a running application. No half-built states.
- The learner should be able to stop at any stage and have something that works.
- Preserve all existing functionality when adding new features.

### Build on what came before
- Each stage extends the previous one. Don't rewrite — add.
- If a concept was introduced in an earlier stage, use it without re-explaining.
- Reference previous stages with links, not repeated explanations.

---

## Documentation Principles

### Write for beginners
- Assume the reader is seeing these concepts for the first time.
- No jargon without explanation. If you use a technical term, define it on first use.
- Use "you" not "we." Direct address is clearer.

### Show, then explain
- Code block first, explanation after. Let the reader see the code before you talk about it.
- Use exact file paths relative to the project root.
- Include the relevant code block before each explanation.

### One concept per explanation
- Don't stack multiple new ideas in the same paragraph.
- If explaining two things, use two separate sections.

### Keep explanations conversational
- Write for someone reading code for the first time.
- Short sentences. Direct language. No filler.
- "This function fetches data from the API" not "The following function serves to facilitate the retrieval of data from the backend API service."

### Brief comments in code
- Add comments only where the *why* isn't obvious. Skip comments on self-explanatory code.
- Don't over-comment. If the code is simple enough, it speaks for itself.
- Comments explain intent, not mechanics: "// Refresh the list after adding" not "// Call fetchFortunes function."

---

## Stage Ordering Principles

Used when building the roadmap:

1. **Scaffold first** — get a running app before adding features
2. **Read before write** — display data before creating/editing it
3. **One concept per stage** — never combine new patterns
4. **Build on the last stage** — each stage extends the previous
5. **Backend before frontend** — add the API endpoint before the UI that calls it
6. **Simple before complex** — basic state before context, inline styles before libraries
7. **CRUD order** — Read → Create → Update → Delete (matches learning difficulty)
8. **Every stage runs** — no half-built states, the app always works

---

## Exercise Principles

Each stage includes 3–5 hands-on exercises:

- **Under 5 minutes each** — quick experiments, not projects
- **Reversible** — the learner can undo changes and return to a working state
- **Break things on purpose** — comment out a line, change a value, see what happens
- **Observe, don't just do** — tell the learner what to look for (browser console, network tab, UI change)
- **Explain what happened** — every exercise ends with a "What happened" section so the learner can verify understanding

---

## Naming Conventions

### Files
- Name components after what they display: `FortuneList`, `AddFortuneForm`, not `List`, `Form`
- Name backend files by their role: `main.py`, `models.py`, `routes.py`
- Use the stack's convention for file naming (PascalCase for React components, snake_case for Python)

### Variables
- State variables describe their content: `fortunes`, `isLoading`, `errorMessage`
- Handler functions describe the action: `handleSubmit`, `fetchFortunes`, `deleteItem`
- Boolean variables start with `is`, `has`, or `should`: `isLoading`, `hasError`

### Branches
- Format: `feature/NN-short-name` (e.g., `feature/01-components`, `feature/05-add-form`)
- Zero-padded stage number for sorting
- Lowercase with hyphens

---

## What NOT to do

- Don't add features, refactor code, or make "improvements" beyond what the stage requires
- Don't add error handling for scenarios that can't happen at this stage
- Don't introduce libraries or tools before the stage that teaches them
- Don't modify README.md with stage-specific content — that belongs in `docs/`
- Don't use `{{ }}` in documentation text (VitePress interprets as Vue templates)
- Don't link to `http://localhost:*` in docs (VitePress flags as dead links)
