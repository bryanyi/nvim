local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, mason_config = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	return
end

mason.setup()

mason_config.setup({
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "sumneko_lua",
    "clangd",
    "dockerls",
    "golangci_lint_ls",
    "prismals",
    "pyright",
    "sqlls",
    "theme_check",
    "yamlls"
  }
})

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "luacheck",
    "eslind_d",
    "golangci_lint",
    "flake8",
    "clang_format",
    "markdownlint",
    "yamlfmt",
    "yamllint",
    "hadolint",
  }
})
