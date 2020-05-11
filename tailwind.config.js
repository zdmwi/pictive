/*
 ** TailwindCSS Configuration File
 **
 ** Docs: https://tailwindcss.com/docs/configuration
 ** Default: https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js
 */
module.exports = {
  theme: {
    extend: {
      colors: {
        relatable: '#262A41',
        society: '#3C3F54'
      }
    }
  },
  variants: {},
  plugins: [require('@tailwindcss/custom-forms')]
}
