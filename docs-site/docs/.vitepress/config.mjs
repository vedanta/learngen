// This is a placeholder config.
// @tutorial-init will replace this with project-specific settings.

import { withMermaid } from 'vitepress-plugin-mermaid'

export default withMermaid({
  title: 'My Tutorial',
  description: 'A staged tutorial built with LearnGen',
  base: '/',
  appearance: 'dark',

  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Overview', link: '/overview' },
    ],

    sidebar: [
      { text: 'Tutorial Overview', link: '/overview' },
      // Stages will be added here by @tutorial-init and @docs-deploy
    ],

    socialLinks: [
      // { icon: 'github', link: 'https://github.com/user/repo' },
    ],

    outline: 'deep',
  },

  mermaid: {
    theme: 'dark',
  },
})
