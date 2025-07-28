require("nvchad.configs.lspconfig").defaults()

local servers = {
    "html",
    "cssls",
    "lua_language_server",
    "clangd",
    "gopls",
    "pyright",
    "fsautocomplete",
    "bashls",
    "lua_ls",
    "ts_ls",
}

vim.lsp.enable(servers)
