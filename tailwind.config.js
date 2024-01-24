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
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ],
}
