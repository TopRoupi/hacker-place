const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  content: [
    './app/**/*.html.erb',
    './app/**/*.rb',
    './config/initializers/*.rb',
    './app/components/**/*.rb',
    './app/components/**/**/*.rb',
    './app/components/**/**/**/*.rb',
    './app/components/**/*.html.erb',
    './app/components/**/**/*.html.erb',
    './app/components/**/**/**/*.html.erb',
    './node_modules/tailwindcss-stimulus-components/**/*.js',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  daisyui: {
      themes: [
        {
          luxury: {
              "color-scheme": "dark",
              "primary": "#dca54c",
              "secondary": "#152747",
              "accent": "#513448",
              "neutral": "#331800",
              "neutral-content": "#FFE7A3",
              "base-100": "#09090b",
              "base-200": "#171618",
              "base-300": "#2e2d2f",
              "base-content": "#cfcfcf",
              "info": "#66c6ff",
              "success": "#87d039",
              "warning": "#e2d562",
              "error": "#ff6f6f",
            },
        },
      ],
      styled: true,
      base: true,
      utils: true,
      logs: true,
      rtl: false,
      prefix: "",
      darkTheme: "luxury",
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require("daisyui"),
  ],
}
