local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local codeActions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- Web Dev
    formatting.prettier,
    -- diagnostics.standardjs,

    -- Lua
    formatting.stylua,
    diagnostics.luacheck,
    diagnostics.selene,

    -- python
    formatting.black.with({ extra_args = { "--fast" } }),

    -- Java
    formatting.google_java_format,

    -- Go
    formatting.gofmt,
    diagnostics.golangci_lint,

    -- XML
    formatting.xmlformat,

    -- YAML
    -- formatting.yamlfmt,
    -- diagnostics.yamllint,
    diagnostics.actionlint,

    -- C++
    formatting.clang_format,
    diagnostics.cppcheck,

  },
})
