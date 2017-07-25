module.exports = {
  config: {
    fontSize: 16,
    uiFontFamily: "\"Fire Code\", monospace",
    fontFamily: "\"Fira Code\", monospace",
    cursorColor: "rgba(248,28,229,0.8)",
    cursorShape: "UNDERLINE",
    cursorBlink: false,
    foregroundColor: "#fff",
    backgroundColor: "#000",
    borderColor: "#333",
    css: "",
    termCSS: "x-screen x-row { font-variant-ligatures: initial; }",
    padding: "16px 8px",
    colors: {
      black: "#000000",
      red: "#ff0000",
      green: "#33ff00",
      yellow: "#ffff00",
      blue: "#0066ff",
      magenta: "#cc00ff",
      cyan: "#00ffff",
      white: "#d0d0d0",
      lightBlack: "#808080",
      lightRed: "#ff0000",
      lightGreen: "#33ff00",
      lightYellow: "#ffff00",
      lightBlue: "#0066ff",
      lightMagenta: "#cc00ff",
      lightCyan: "#00ffff",
      lightWhite: "#ffffff"
    },
    pokemon: "dragonite",
    pokecursor: "true",
    shell: "zsh",
    shellArgs: [
      "--login"
    ],
    env: {},
    bell: "SOUND",
    copyOnSelect: false,
    color: "dark",
    unibody: false
  },
  plugins: [
    "hyper-pokemon",
    "hypercwd",
    "hyperterm-paste",
    "hyperterm-alternatescroll",
    "hyper-tab-icons",
    "hyperminimal",
    "hyper-spotify"
  ],
  localPlugins: []
};
