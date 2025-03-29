-- some overrides to the default Lazy configuration

return {
  "saghen/blink.cmp",

  opts = {
    completion = {
      list = {
        -- Do not select anything, use Ctrl+y to select
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
  },
}
