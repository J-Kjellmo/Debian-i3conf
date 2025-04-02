return  {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies =  {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0",
    },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      vim.cmd([[
          highlight TelescopeNormal guibg=NONE ctermbg=NONE
          highlight TelescopeBorder guibg=NONE ctermbg=NONE
          highlight TelescopePromptNormal guibg=NONE ctermbg=NONE
          highlight TelescopePromptBorder guibg=NONE ctermbg=NONE
          highlight TelescopeResultsNormal guibg=NONE ctermbg=NONE
          highlight TelescopeResultsBorder guibg=NONE ctermbg=NONE
          highlight TelescopePreviewNormal guibg=NONE ctermbg=NONE
          highlight TelescopePreviewBorder guibg=NONE ctermbg=NONE
      ]])
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}

