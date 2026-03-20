# LearnGen User Manual

## What is LearnGen?

LearnGen is a GitHub template that helps you build staged tutorial projects using AI agents. You describe what you want to teach, and LearnGen scaffolds the project, builds each stage's code and documentation, and deploys a docs site — all driven by a structured roadmap.

---

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI installed
- Git and GitHub CLI (`gh`) installed
- Node.js 24+ with npm
- A GitHub account

---

## Quick Start

### 1. Create your tutorial repo

```bash
gh repo create my-tutorial --template vedanta/learngen --public --clone
cd my-tutorial
```

### 2. Initialize the tutorial

```
@tutorial-init "Build a URL shortener with Go and SQLite"
```

This starts a 5-round interactive flow that builds your roadmap and scaffolds the project. See [The Init Flow](#the-init-flow) below.

### 3. Install docs dependencies

```bash
cd docs-site && npm install && cd ..
```

### 4. Enable GitHub Pages

```bash
gh api repos/<your-username>/<your-repo>/pages -X POST -f build_type=workflow
```

### 5. Build your first stage

```
@tutorial-turbo
```

This builds Stage 0 (code + docs) and deploys it to your docs site. Run it again for each subsequent stage.

---

## The Init Flow

`@tutorial-init` asks questions in 5 rounds, offering smart defaults at each step.

### Round 1: Big Picture

The agent infers your project from the idea you provided:

- **What are you building?** — one-sentence description
- **Who is the learner?** — skill level, what they know already
- **What stack?** — languages, frameworks, tools (auto-detected from your idea)

Review the defaults and adjust anything that's off.

### Round 2: End State

- **What does the finished app do?** — capabilities when all stages are complete
- **How many stages?** — suggested based on complexity (8–15 is typical)

### Round 3: Stage Breakdown

The agent proposes a stage-by-stage progression. Each stage has:
- A title
- One concept it introduces
- What changes in the app
- A short summary

Review and adjust — reorder, split, merge, add, or remove stages.

### Round 4: Grouping

Stages are organized into 3–5 groups (e.g., Foundation, Core Features, Polish). Each group gets a name, icon, and one-line description.

### Round 5: Confirm & Scaffold

The agent shows the complete plan and generates all project files:
- `docs/ROADMAP.md` — your structured roadmap
- `CLAUDE.md` — coding standards for your stack
- `README.md` — project README with badges
- `Makefile` — dev commands
- VitePress site config, landing page, overview
- `.tutorial-state.json` — pipeline state (all stages pending)

---

## Building Stages

### Build the next stage

```
@tutorial-turbo
```

Finds the first pending stage, builds it (code + 8 doc files), deploys to the site.

### Build a specific stage

```
@tutorial-turbo --stage=5
```

### Check progress

```
@tutorial-turbo --status
```

Shows a table of all stages and their status (pending, building, built, deployed).

### What happens during a build

1. Creates a feature branch from the previous stage
2. Reads your roadmap for what to build
3. Implements the code following your `CLAUDE.md` standards
4. Generates 8 documentation files (see [Doc Files](#doc-files-per-stage))
5. Self-reviews for correctness and beginner-friendliness
6. Commits and pushes the feature branch
7. Switches to main and deploys docs to the VitePress site
8. Updates the landing page, sidebar, overview, and badge
9. Pushes main — GitHub Actions deploys to Pages

---

## Doc Files Per Stage

Every stage gets these 8 files in its `docs/` folder:

| File | What it contains |
|------|-----------------|
| `stage.json` | Machine-readable metadata (number, title, branch, concept, stack) |
| `readme.md` | What you'll learn, prerequisites, outcome |
| `changelog.md` | What changed from the previous stage |
| `steps.md` | Step-by-step recipe to build the stage from scratch |
| `walkthrough.md` | Line-by-line code explanation with GitHub source links |
| `architecture.md` | Project structure and mermaid data flow diagrams |
| `exercises.md` | 3–5 hands-on experiments (reversible, under 5 minutes) |
| `troubleshooting.md` | Common errors and FAQ for this stage |

---

## Using Individual Agents

The pipeline agents can also be used standalone:

| Command | What it does |
|---------|-------------|
| `@tutorial-init "idea"` | Build a roadmap interactively |
| `@tutorial-init --import=file` | Build a roadmap from an existing outline |
| `@tutorial-turbo` | Build + deploy the next stage |
| `@tutorial-turbo --status` | Show progress |
| `@docs-turbo --stage=N` | Build code + docs on a feature branch (no deploy) |
| `@docs-deploy --stage=N` | Deploy an already-built stage to the site |
| `@docs-stage-prep --stage=N` | Validate docs before deploying |
| `@tutorial-coder` | Implement code only (manual use on a feature branch) |
| `@tutorial-reviewer` | Review code + docs for correctness |

---

## The Roadmap File

`docs/ROADMAP.md` is the single source of truth. It has two parts:

**YAML frontmatter** — machine-readable metadata:
```yaml
---
title: "My Tutorial"
repo: "username/repo"
base: "/repo/"
accent: "amber"
stack: { ... }
groups: [ ... ]
stages: [ ... ]
---
```

**Markdown body** — detailed descriptions per stage:
```markdown
## Stage 0 — Hello World

**Concept:** Project setup

- What the stage does...
- What the learner builds...

**Branch:** `main` | **Tag:** `v0-hello-world`
```

The agents read the frontmatter for metadata and the markdown body for detailed requirements.

---

## Pipeline State

`.tutorial-state.json` tracks build progress locally (gitignored):

```json
{
  "stages": {
    "0": { "status": "deployed" },
    "1": { "status": "built" },
    "2": { "status": "pending" }
  }
}
```

**Statuses:** `pending` → `building` → `built` → `deployed`

If a build is interrupted, rerun `@tutorial-turbo` — it picks up where it left off.

---

## Customization

### Accent colors

Set in `docs/ROADMAP.md` frontmatter (`accent` field) and applied to `docs-site/docs/.vitepress/theme/custom.css`.

| Preset | Color |
|--------|-------|
| `amber` | #f59e0b (default) |
| `blue` | #3b82f6 |
| `green` | #10b981 |
| `purple` | #8b5cf6 |
| `rose` | #f43f5e |

### Adding stages after init

1. Edit `docs/ROADMAP.md` — add a new entry to `stages` array and the markdown body
2. Add the stage number to the appropriate group in `groups`
3. Run `@tutorial-turbo --stage=N` to build it

### Changing stage order

Edit the `stages` array in `docs/ROADMAP.md`. The `number` field determines order. Update `groups` accordingly. Rebuild affected stages.

---

## The Docs Site

Your tutorial gets a VitePress site with:

- **Dark mode** default (user can toggle)
- **Mermaid diagrams** rendered as SVG
- **Collapsible sidebar** — each stage expands to show its pages
- **Landing page** — hero, feature cards, visual pipeline, grouped stage cards
- **Auto-deploy** — push to main triggers GitHub Actions → GitHub Pages

The site lives at `https://<username>.github.io/<repo>/`

---

## Troubleshooting

### `@tutorial-turbo` can't create branches

The sandbox may block `git checkout`. Create the branch manually:
```bash
git checkout -b feature/NN-name previous-branch
```
Then rerun `@tutorial-turbo`.

### VitePress build fails with "dead link"

Don't use `[http://localhost:5173](http://localhost:5173)` in docs. Use backtick code spans instead: `` `http://localhost:5173` ``

### VitePress build fails with "Error parsing JavaScript expression"

You have `{{ }}` (double curly braces) in regular text. VitePress interprets these as Vue template expressions. Wrap them in backtick code spans or keep them inside fenced code blocks.

### Stage deploys but the landing page card isn't highlighted

The `docs-deploy` agent needs to change the card's `<div>` to `<a>` with the `available` class. Check `docs-site/docs/index.md` for the stage card markup.

### Pipeline state is out of sync

Delete `.tutorial-state.json` and rerun `@tutorial-turbo --status` — it will be recreated from the current state of branches and the docs site.

---

## Reference

- [LEARNGEN.md](LEARNGEN.md) — Full design document
- [TEACHING.md](TEACHING.md) — Teaching principles all agents follow
- [STANDARD.md](STANDARD.md) — 8-file documentation standard per stage
- [ROADMAP.md](ROADMAP.md) — Roadmap format reference
