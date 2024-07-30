--print("hello from lua/init.lua!")

require("core.options")
require("core.mappings")
require("core.lazy_init")


vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable automatic comment insertion",
  group = vim.api.nvim_create_augroup("AutoComment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})


