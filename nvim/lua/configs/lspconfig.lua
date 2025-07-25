require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua_language_server", "clangd", "gopls", "pyright", "fsautocomplete" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
