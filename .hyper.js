// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // Choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/usr/local/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {
      PURE_PROMPT_SYMBOL: '⚡︎'
    },

    // set to false for no bell
    bell: false,

    // The number of rows to be persisted in terminal buffer for scrolling
    scrollback: 10000,

    // for advanced config flags please refer to https://hyper.is/#cfg

    // WALLACE THEME
    backgroundColor: 'hsl(203.3, 27.3%, 12.9%)',
    foregroundColor: 'hsl(198, 5%, 97.3%)',
    cursorColor: '#24ad6d',
    selectionColor: 'hsla(198.6, 19.6%, 20.8%, .3)',
    colors: {
      blue: '#24ad6d',
      red: 'hsl(0, 70%, 51%)',
      magenta: 'hsl(42, 100%, 55%)',
    }
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hypercwd', // Open a new tab in the same dir as the current one
    // 'hyper-snazzy', // Theme
    'hyper-tab-icons', // Tab icons
    'hyperterm-cursor', // Make text underneath cursor visible
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
};
