module.exports = {
  content: ["./**/*.app", "./javascript/*.js"],
  theme: {
    extend: {},
  },
  plugins: [
    require("tailwind-scrollbar"),
    require("@tailwindcss/typography"),
    require("daisyui"),
  ],
  variants: {
    scrollbar: ["rounded"],
  },
  daisyui: {
    themes: ["dracula"],
  },
};
