-- set options
require 'config.options'

-- set auto commands
require 'config.autocmds'

-- set core keymaps
local keymaps = require 'config.keymaps'

-- bootstrap lazy.nvim, LazyVim and your plugins
require 'config.lazy'

keymaps.setup_toggles()
