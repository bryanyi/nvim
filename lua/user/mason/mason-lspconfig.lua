local status_ok, mason_config = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

mason_config.setup()
