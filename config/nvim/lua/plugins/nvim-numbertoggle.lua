return {
  "sitiom/nvim-numbertoggle",
  config = function()
    local numbertoggle_enabled = true

    function ToggleNumberToggle()
      numbertoggle_enabled = not numbertoggle_enabled
      if numbertoggle_enabled then
        vim.cmd("doautocmd User NumberToggle")
        print("nvim-numbertoggle: Enabled")
      else
        vim.opt.number = true
        vim.opt.relativenumber = false
        vim.cmd("autocmd! * <buffer>")
        print("nvim-numbertoggle: Disabled")
      end
    end

    vim.api.nvim_create_user_command("ToggleNumberToggle", ToggleNumberToggle, {})
    vim.keymap.set('n', '<C-l>', ':ToggleNumberToggle<CR>', { noremap = true, silent = true })
  end
}

