return {
  "windwp/nvim-ts-autotag",
  config = function ()
    local config = require('nvim-ts-autotag')
    config.setup({
     opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
      },
      per_filetype = {
        ["html"] = {
          enable_close = false
        }
      }
    })
  end
}
