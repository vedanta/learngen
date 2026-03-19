# Documentation Standard

This file defines the documentation structure for every tutorial stage. Every branch must follow this standard so the tutorial website can consume the docs consistently.

---

## Root Files (same across all branches)

### `README.md`

The project-level introduction. Does NOT contain stage-specific content.

**Must include:**
- Project purpose (one paragraph)
- How to use this tutorial (branch-per-stage model)
- Quick start / setup instructions
- Links to stage-specific docs in `docs/`
- Tech stack summary table
- Authors
- License

---

## Stage Docs (`docs/`)

Every branch has a `docs/` folder with these 8 files. Each file covers only its own stage — not previous or future stages.

```
docs/
├── stage.json
├── readme.md
├── changelog.md
├── steps.md
├── walkthrough.md
├── architecture.md
├── exercises.md
└── troubleshooting.md
```

---

### `stage.json`

Machine-readable metadata. The tutorial website reads this to build navigation, ordering, and stack badges.

```json
{
  "number": 0,
  "title": "Stage title",
  "branch": "main",
  "tag": "v0-base-working-app",
  "previous": null,
  "concept": "primary concept name",
  "summary": "One sentence describing what this stage does",
  "stack": {
    "backend": {
      "python": "3.11",
      "fastapi": "0.104",
      "uvicorn": "0.24"
    },
    "frontend": {
      "react": "19.2",
      "vite": "8.0.0-beta.13",
      "node": "23"
    },
    "tools": {
      "conda": "fortune-api",
      "eslint": "9"
    }
  }
}
```

**Fields:**

| Field | Type | Description |
|-------|------|-------------|
| `number` | int | Stage number (0 = base) |
| `title` | string | Human-readable stage name |
| `branch` | string | Git branch name |
| `tag` | string | Git tag for this stage |
| `previous` | string or null | Branch name of the previous stage (`null` for stage 0) |
| `concept` | string | Primary concept taught in this stage |
| `summary` | string | One-sentence description |
| `stack` | object | Grouped by layer. Only include what changed if versions bump between stages |

---

### `readme.md`

Stage introduction. The first thing a learner reads for this stage.

**Template:**

```markdown
# Stage N — Title

> One-sentence summary of what this stage accomplishes.

## What You'll Learn

- Concept 1
- Concept 2

## Prerequisites

What you should understand before starting this stage (link to previous stage).

## What Changes

High-level summary of what files are added, modified, or removed. Not a diff — a narrative explanation.

## Outcome

What the app looks like / does after completing this stage.
```

---

### `changelog.md`

A structured record of what changed from the previous stage. This is the "diff with context."

**Template:**

```markdown
# Changelog — Stage N: Title

## Previous Stage

Stage N-1: Title (branch: `branch-name`)

## Files Changed

| File | Change | What and Why |
|------|--------|--------------|
| `path/to/file` | added / modified / removed | Brief explanation |

## Summary

One paragraph explaining the overall change and why it was made.
```

---

### `steps.md`

Step-by-step recipe to build this stage from scratch. The learner follows these commands and file edits in order. This is the "do it yourself" companion to the walkthrough.

**Template:**

```markdown
# Steps — Stage N: Title

> Follow these steps in order. Each step is either a command to run or a file to create/edit.

## Prerequisites

Completed Stage N-1. Both servers should be stopped before starting.

## Steps

### 1. Description of first step

\`\`\`bash
command to run
\`\`\`

Brief context: what this command does and why.

### 2. Create `path/to/file`

\`\`\`jsx
file contents
\`\`\`

Brief context: what this file does.

### 3. Edit `path/to/file`

Change the import section to add the new component:

\`\`\`jsx
// Add this line after the existing imports
import NewComponent from './components/NewComponent'
\`\`\`

(Repeat for each step)

## Verify

How to confirm everything works after completing all steps.
```

**Rules:**
- Each step is either a terminal command or a file create/edit — no ambiguity
- Steps must be in the exact order needed (dependencies first)
- Include the complete file contents for new files — don't make the learner guess
- For edits to existing files, show what to add/change and where
- Keep context sentences to 1–2 lines — the walkthrough has the deep explanations
- End with a "Verify" section so the learner knows they succeeded
- Assume the previous stage is complete and working

---

### `walkthrough.md`

Line-by-line code explanation scoped to this stage's changes. This is the core teaching content.

**Template:**

```markdown
# Walkthrough — Stage N: Title

> Open each file side by side with this walkthrough. Read the code first, then read the explanation.

## File: `path/to/file`

### Lines X–Y: Section name

(code block)

**What's happening:**

Plain English explanation. One concept at a time. Explain *why*, not just *what*.

(Repeat for each significant code section changed in this stage)
```

**Rules:**
- Only cover code that changed in this stage
- Use exact file paths relative to project root
- Include the relevant code block before each explanation
- Keep explanations conversational — write for someone reading code for the first time
- If a concept was explained in a previous stage, link to it instead of re-explaining

---

### `architecture.md`

How the app's architecture looks at this stage and what changed structurally.

**Template:**

```markdown
# Architecture — Stage N: Title

## Current Structure

File tree or diagram showing the project layout at this stage.

## Data Flow

How data moves through the app at this stage (text or diagram).

## What Changed

What structural change this stage introduced and why it matters.
(Only for stages that change architecture — e.g., new folders, new data flow patterns)
```

**Rules:**
- Include a file tree showing the project structure at this stage
- Use mermaid diagrams for data flow when helpful
- For stages that don't change architecture (e.g., a CSS-only change), keep this short: "No structural changes. See Stage N for current architecture."

---

### `exercises.md`

Hands-on experiments the learner can try. These build intuition through doing, not reading.

**Template:**

```markdown
# Exercises — Stage N: Title

## Exercise 1: Title

**Goal:** What you'll understand after doing this.

**Steps:**
1. Do X
2. Observe Y

**What happened:** Explanation of why you saw what you saw.

## Exercise 2: Title

(repeat)
```

**Rules:**
- Each exercise should take under 5 minutes
- Tell the learner what to observe, not just what to do
- Include a "What happened" explanation so they can verify understanding
- Exercises should be reversible — the learner should be able to undo changes and get back to a working state
- 3–5 exercises per stage is ideal

---

### `troubleshooting.md`

Common mistakes and questions specific to this stage's concepts.

**Template:**

```markdown
# Troubleshooting — Stage N: Title

## Common Errors

### Error or symptom

**Cause:** Why this happens.

**Fix:** How to resolve it.

## FAQ

### Question?

Answer.
```

**Rules:**
- Only include issues related to this stage's concepts
- Lead with the error message or symptom the learner would actually see
- Keep answers short and actionable
- 3–5 entries per section is a good target

---

## Writing Guidelines

These apply to all docs files:

1. **Write for beginners.** Assume the reader is seeing these concepts for the first time. No jargon without explanation.
2. **One concept per explanation.** Don't stack multiple new ideas in the same paragraph.
3. **Show, then explain.** Code block first, explanation after.
4. **Use "you" not "we."** Direct address is clearer.
5. **Keep files focused.** Each file has one job. Don't put exercises in the walkthrough or architecture in the changelog.
6. **Link, don't repeat.** If a concept was covered in a previous stage, link to it.
7. **Use descriptive names.** `fortune.message` not `f.m`, `fetchFortunes()` not `getData()`.
