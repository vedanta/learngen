# CLAUDE.md

## Project Overview

LearnGen is a GitHub template for building staged tutorial projects with AI agents. Users clone this template, run `@tutorial-init` to set up their tutorial, then run `@tutorial-turbo` to build stages one at a time.

**This file serves two purposes:**
1. When developing LearnGen itself — tells agents how this repo works
2. When cloned as a template — gets replaced by `@tutorial-init` with project-specific coding standards

## Architecture

- **`.claude/agents/`** — 7 AI agents that power the pipeline (init, turbo, coder, reviewer, docs-turbo, docs-deploy, docs-stage-prep)
- **`docs/TEACHING.md`** — Universal teaching principles (simplicity, one concept per stage, naming)
- **`docs/STANDARD.md`** — 8-file documentation standard per stage
- **`docs/ROADMAP.md`** — Placeholder for the tutorial roadmap (YAML frontmatter + markdown)
- **`docs/LEARNGEN.md`** — Full design document
- **`docs-site/`** — VitePress scaffold (placeholder pages, theme, mermaid plugin)
- **`.github/workflows/deploy-docs.yml`** — GitHub Pages auto-deploy

## Key Files

| File | Role |
|------|------|
| `docs/TEACHING.md` | Teaching philosophy — all agents read this |
| `docs/STANDARD.md` | Doc structure — defines the 8 files per stage |
| `docs/ROADMAP.md` | Placeholder — `tutorial-init` generates the real one |
| `docs/LEARNGEN.md` | Design doc — explains the full system |

## When Developing LearnGen

- Agent prompts must be **stack-agnostic** — they read coding rules from `CLAUDE.md` (generated per-project), not hardcoded
- All teaching principles go in `TEACHING.md`, not scattered across agent prompts
- Test changes against the Fortune App (the reference implementation at `vedanta/fortune-app`)
- The Fortune App repo has LearnGen as a submodule — develop there, sync here

## When Cloned as a Template

`@tutorial-init` replaces this file with project-specific content:
- Project overview and architecture
- Tech stack details
- Development commands
- Coding standards for the chosen stack
