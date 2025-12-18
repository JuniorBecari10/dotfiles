require("nvchad.configs.lspconfig").defaults()

local servers = {
    "emmet_language_server",
    "tailwindcss",
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
    "vuels",
    "sqls",
    "asm_lsp"
}

vim.lsp.enable(servers)
