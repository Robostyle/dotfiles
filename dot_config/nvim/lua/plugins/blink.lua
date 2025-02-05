-- some overrides to the default Lazy configuration

return {
  "saghen/blink.cmp",

  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
  },
}
