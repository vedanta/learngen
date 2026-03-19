---
name: docs-deploy
description: "Pulls stage docs to main and builds the site. Usage: @docs-deploy --stage=N"
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You pull a stage's documentation into the VitePress site on `main` and build it. Run this after `@docs-turbo` has prepared the stage.

**You receive a `--stage=N` argument.** If none, stop and ask.

## Step 1: Preflight checks

1. Switch to `main` and pull latest.
2. Read `docs/ROADMAP.md` frontmatter to get the stage's branch name and title.
3. Find the feature branch: `git branch -r --list "origin/<branch>"`
4. Verify `docs/stage.json` exists on the branch.
5. Validate all 7 doc files exist on the branch.

## Step 2: Pull docs

```bash
./docs-site/scripts/pull-stage-docs.sh origin/<branch>
```

If the script fails, pull manually with `git show`:
- `docs/readme.md` → `docs-site/docs/stage-NN/index.md`
- `docs/changelog.md` → `docs-site/docs/stage-NN/changelog.md`
- `docs/steps.md` → `docs-site/docs/stage-NN/steps.md`
- `docs/walkthrough.md` → `docs-site/docs/stage-NN/walkthrough.md`
- `docs/architecture.md` → `docs-site/docs/stage-NN/architecture.md`
- `docs/exercises.md` → `docs-site/docs/stage-NN/exercises.md`
- `docs/troubleshooting.md` → `docs-site/docs/stage-NN/troubleshooting.md`

## Step 3: Update sidebar

Edit `docs-site/docs/.vitepress/config.mjs`:
1. Add nav entry: `{ text: 'Stage N', link: '/stage-NN/' }`
2. Add collapsed sidebar group with 7 page links (Overview, Changelog, Steps, Walkthrough, Architecture, Exercises, Troubleshooting)
3. Keep stages ordered by number.

## Step 4: Update landing page and overview

In `docs-site/docs/index.md`:
- Find the stage card and change `<div class="stage-card">` to `<a href="/<base>stage-NN/" class="stage-card available">`
- Change closing `</div>` to `</a>`

In `docs-site/docs/overview.md`:
- Add link to stage in the table: `| [Stage N](/stage-NN/) | ... |`

## Step 5: Update stages badge

Update badge in `README.md`:
```
![Stages](https://img.shields.io/badge/stages-N%2F<total>-F59E0B)
```

## Step 6: Build and verify

```bash
cd docs-site && npm run docs:build
```

Fix any build errors.

## Step 7: Report

Report: stage pulled, files written, sidebar updated, build status.

## Rules

- Only modifies files in `docs-site/` and `README.md` (badge).
- Uses `git show` to read from feature branches — never checks them out.
- Always stays on `main`.
- Does not push — lets the user review and decide.
