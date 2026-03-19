# LearnGen

A GitHub template for building staged tutorial projects with AI agents.

**Turn a tutorial idea into a complete learning site — one command at a time.**

## Quick Start

```bash
# 1. Create your tutorial repo from this template
gh repo create my-tutorial --template vedanta/learngen --public --clone
cd my-tutorial

# 2. Initialize (interactive 5-round flow)
# @tutorial-init "Build a URL shortener with Go and SQLite"

# 3. Install docs dependencies
cd docs-site && npm install && cd ..

# 4. Enable GitHub Pages
gh api repos/<user>/<repo>/pages -X POST -f build_type=workflow

# 5. Build stages one at a time
# @tutorial-turbo           # builds + deploys next stage
# @tutorial-turbo --status  # check progress
```

## What It Does

1. **`@tutorial-init`** — Asks 5 rounds of questions, generates a structured roadmap and scaffolds the entire project
2. **`@tutorial-turbo`** — Reads the roadmap, builds one stage (code + 8 doc files), deploys to the docs site
3. **Repeat** until all stages are deployed

## What You Get

- Branch-per-stage tutorial with working code at every stage
- VitePress docs site with dark mode, mermaid diagrams, collapsible sidebar
- Landing page with grouped stage cards and progress indicators
- 8 documentation files per stage (overview, changelog, steps, walkthrough, architecture, exercises, troubleshooting)
- GitHub Actions auto-deployment to GitHub Pages
- Pipeline state tracking for resumable builds

## Documentation

See [docs/LEARNGEN.md](docs/LEARNGEN.md) for the full design document.

## Reference Implementation

The [Fortune App](https://github.com/vedanta/fortune-app) tutorial was built with this pattern.

## Authors

Vedanta

## License

MIT
