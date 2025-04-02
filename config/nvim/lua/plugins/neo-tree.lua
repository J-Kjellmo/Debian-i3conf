return  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>')
    vim.cmd([[
        highlight NeoTreeNormal guibg=NONE ctermbg=NONE
        highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
    ]])

    require('neo-tree').setup({
      window = {
        mappings = {
          ["J"] = function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require('neo-tree.ui.renderer')
            renderer.focus_node(state, siblings[#siblings]:get_id())
          end,
          ["K"] = function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require('neo-tree.ui.renderer')
            renderer.focus_node(state, siblings[1]:get_id())
          end
        }
      }
    })
  end
}

