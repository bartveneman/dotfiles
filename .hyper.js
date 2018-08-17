// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // Choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: "stable",

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: "Menlo, monospace",

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: "/usr/local/bin/zsh",

    // set to false for no bell
    bell: false,

    // The number of rows to be persisted in terminal buffer for scrolling
    scrollback: 100000,

    // for environment variables
    env: {
      PURE_PROMPT_SYMBOL: '⚡︎'
    },

    // if true, on right click selected text will be copied or pasted if no
    // selection is present (true by default on Windows)
    // quickEdit: true

    // for advanced config flags please refer to https://hyper.is/#cfg
    paneNavigation: {
      showIndicators: false,
      focusOnMouseHover: true
    },

    // WALLACE THEME
    backgroundColor: 'hsl(203.3, 27.3%, 12.9%)',
    foregroundColor: 'hsl(198, 5%, 97.3%)',
    cursorColor: '#24ad6d',
    selectionColor: 'hsla(335.9, 89%, 50%, .3)',
    colors: {
      blue: '#29c87d',
      red: 'hsl(0, 70%, 51%)',
      magenta: 'hsl(42, 100%, 55%)',
      green: '#61df0c'
    },
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    "hypercwd", // Open a new tab in the same dir as the current one
    "hyper-tab-icons", // Tab icons
    // "hyper-snazzy", // Theme
    // 'hyper-pane', // Autofocus on hover (broken in Hyper v2.0.0)
    // 'hyper-simple-highlight-active-session', // Highlight active pane (Not needed since Hyper v2.0.0?)
    // "hyperterm-cursor", // Make text underneath cursor visible (Not needed since Hyper v2.0.0?)
  ]
};
