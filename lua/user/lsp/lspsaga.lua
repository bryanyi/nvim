local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  return
end

saga.init_lsp_saga({
  diagnostic_header = { "😡 ", "😥 ", "😤 ", "😐 " },
  code_action_lightbulb = {
    enable = false,
    -- enable_in_insert = true,
    -- cache_code_action = true,
    -- sign = true,
    -- update_time = 150,
    -- sign_priority = 20,
    -- virtual_text = true,
  },
  finder_icons = {
    def = "🔖",
    ref = "📖",
    link = "🔗",
  },
  finder_action_keys = {
    open = "<CR>",
  },
  definition_action_keys = {
    edit = "<CR>",
  },
  -- symbol_in_winbar = {
  --   in_custom = false,
  --   enable = true,
  --   -- separator = '',
  --   -- show_file = true,
  --   -- -- define how to customize filename, eg: %:., %
  --   -- -- if not set, use default value `%:t`
  --   -- -- more information see `vim.fn.expand` or `expand`
  --   -- -- ## only valid after set `show_file = true`
  --   -- file_formatter = "",
  --   -- click_support = false,
  -- },
})
