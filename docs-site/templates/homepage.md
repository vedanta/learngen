# Homepage Template Reference

This file documents the homepage structure that `@tutorial-init` generates.
It is NOT a VitePress page — it's a reference for the `tutorial-init` agent.

## Structure

The homepage (`docs-site/docs/index.md`) has these sections:

### 1. VitePress Frontmatter (YAML)

```yaml
---
layout: home

hero:
  name: {{PROJECT_NAME}}
  text: {{HERO_TEXT}}
  tagline: "{{TAGLINE}}"
  actions:
    - theme: brand
      text: Start the Tutorial
      link: /overview
    - theme: alt
      text: View on GitHub
      link: https://github.com/{{REPO}}

features:
  - title: One Concept Per Stage
    details: "Each of the {{STAGE_COUNT}} stages introduces exactly one idea. You never juggle multiple new things at once."
    icon: 🎯
  - title: Always a Working App
    details: Every stage ends with a running app. Nothing half-built, nothing broken. You see results immediately.
    icon: ✅
  - title: Read the Code, Not Just About It
    details: Every file gets a line-by-line walkthrough. You learn by reading real code, not abstract examples.
    icon: 📖
  - title: Break Things on Purpose
    details: Each stage has hands-on exercises. Learning by doing.
    icon: 🔧
---
```

### 2. What You'll Build

A one-paragraph description + the data/concept flow pipeline visual:

```html
<div class="data-flow-visual">
  <!-- One .flow-step per pipeline stage, separated by .flow-arrow -->
  <div class="flow-step">
    <div class="flow-icon">{{ICON}}</div>
    <div class="flow-label">{{LABEL}}</div>
  </div>
  <div class="flow-arrow">→</div>
  <!-- repeat -->
</div>
<p class="flow-caption">{{CAPTION}}</p>
```

The pipeline steps come from the tutorial's data flow (e.g., File → API → HTTP → Frontend → Browser).

### 3. Stage Grid

Groups from ROADMAP.md `groups` array. Each group has:

```html
<div class="stage-group">
  <h3>{{GROUP_ICON}} {{GROUP_NAME}}</h3>
  <p class="group-desc">{{GROUP_DESC}}</p>
  <!-- All stages start as dimmed divs. docs-deploy converts to clickable <a> tags. -->
  <div class="stage-card">
    <span class="stage-num">{{N}}</span>
    <div>
      <strong>{{STAGE_TITLE}}</strong>
      <p>{{STAGE_SUMMARY}}</p>
    </div>
  </div>
</div>
```

### 4. Tech Stack Cards

2-4 cards from the ROADMAP.md `stack` sections:

```html
<div class="stack-cards">
  <div class="stack-card">
    <div class="stack-icon">{{ICON}}</div>
    <h4>{{TECH_NAME}}</h4>
    <p>{{ONE_LINE_BENEFIT}}</p>
  </div>
</div>
```

### 5. Who This Is For

```html
<div class="audience-list">
  <p><strong>You'll get the most out of this if you:</strong></p>
  <ul>
    <li>{{AUDIENCE_POINT}}</li>
  </ul>
  <p><strong>You don't need:</strong></p>
  <ul>
    <li>{{NOT_NEEDED_POINT}}</li>
  </ul>
</div>
```

### 6. CTA

```html
<div class="cta-section">
  <a href="/{{BASE}}overview" class="cta-button">Start with the Overview →</a>
</div>
```

## CSS

The CSS is fully reusable across all tutorials. Copy it as-is into the generated `index.md`.

```css
.home-content {
  max-width: 960px;
  margin: 0 auto;
  padding: 2rem 1.5rem 4rem;
}

.home-content h2 {
  font-size: 1.6rem;
  margin-top: 3rem;
  margin-bottom: 1.2rem;
  border-bottom: 2px solid var(--vp-c-brand-1);
  padding-bottom: 0.5rem;
  display: inline-block;
}

/* Data flow visual */
.data-flow-visual {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  margin: 2rem 0 0.5rem;
  flex-wrap: wrap;
}

.flow-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.3rem;
  padding: 0.8rem 1rem;
  background: var(--vp-c-bg-soft);
  border-radius: 10px;
  border: 1px solid var(--vp-c-divider);
  min-width: 80px;
}

.flow-icon { font-size: 1.8rem; }
.flow-label { font-size: 0.8rem; font-weight: 600; color: var(--vp-c-text-2); }
.flow-arrow { font-size: 1.4rem; color: var(--vp-c-brand-1); font-weight: bold; }
.flow-caption { text-align: center; color: var(--vp-c-text-2); font-style: italic; margin-top: 0.5rem; font-size: 0.95rem; }

/* Stage grid */
.stage-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  margin: 1.5rem 0;
}

.stage-group h3 { margin-bottom: 0.2rem; font-size: 1.1rem; }
.group-desc { margin: 0 0 0.6rem; font-size: 0.85rem; color: var(--vp-c-text-3); line-height: 1.4; }

.stage-card {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  padding: 0.75rem;
  border-radius: 8px;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  margin-bottom: 0.5rem;
  opacity: 0.55;
}

.stage-card.available {
  opacity: 1;
  border-color: var(--vp-c-brand-soft);
  background: var(--vp-c-brand-soft);
}

a.stage-card {
  text-decoration: none !important;
  color: inherit !important;
  cursor: pointer;
  transition: border-color 0.2s, transform 0.15s;
}

a.stage-card:hover {
  border-color: var(--vp-c-brand-1);
  transform: translateY(-1px);
}

.stage-card strong { display: block; font-size: 0.95rem; }
.stage-card p { margin: 0.15rem 0 0; font-size: 0.85rem; color: var(--vp-c-text-2); }

.stage-num {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 2rem;
  height: 2rem;
  border-radius: 50%;
  background: var(--vp-c-brand-1);
  color: var(--vp-c-bg);
  font-weight: 700;
  font-size: 0.85rem;
  flex-shrink: 0;
}

.stage-card:not(.available) .stage-num {
  background: var(--vp-c-divider);
  color: var(--vp-c-text-3);
}

/* Stack cards */
.stack-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1rem;
  margin: 1rem 0;
}

.stack-card {
  padding: 1.2rem;
  border-radius: 10px;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  text-align: center;
}

.stack-icon { font-size: 2rem; margin-bottom: 0.5rem; }
.stack-card h4 { margin: 0 0 0.4rem; font-size: 1rem; }
.stack-card p { margin: 0; font-size: 0.9rem; color: var(--vp-c-text-2); }

/* Audience */
.audience-list {
  background: var(--vp-c-bg-soft);
  border-radius: 10px;
  padding: 1.5rem 2rem;
  border: 1px solid var(--vp-c-divider);
}

.audience-list p { margin-bottom: 0.5rem; }
.audience-list ul { margin-bottom: 1rem; }

/* CTA */
.cta-section { text-align: center; margin-top: 3rem; }

.cta-button {
  display: inline-block;
  padding: 0.8rem 2rem;
  background: var(--vp-c-brand-1);
  color: var(--vp-c-bg) !important;
  border-radius: 8px;
  font-weight: 600;
  font-size: 1.1rem;
  text-decoration: none !important;
  transition: background 0.2s;
}

.cta-button:hover { background: var(--vp-c-brand-2); }

/* Mobile */
@media (max-width: 640px) {
  .data-flow-visual { gap: 0.3rem; }
  .flow-step { padding: 0.5rem; min-width: 60px; }
  .flow-icon { font-size: 1.4rem; }
  .flow-label { font-size: 0.7rem; }
  .stage-grid { grid-template-columns: 1fr; }
}
```

## How tutorial-init uses this

1. Read ROADMAP.md frontmatter for: title, repo, base, groups, stages, stack
2. Fill in the template placeholders with project-specific values
3. Generate the pipeline visual from the tutorial's data flow
4. Generate stage cards from the groups and stages arrays (all dimmed initially)
5. Generate tech stack cards from the stack config
6. Generate audience section based on the learner profile from Round 1
7. Write the complete `index.md` with the CSS block at the bottom
