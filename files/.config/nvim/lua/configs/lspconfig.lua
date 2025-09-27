require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
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

lspconfig.emmet_language_server.setup({
  filetypes = {
    "html",
    "css",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
  },
})

lspconfig.tailwindcss.setup({
  filetypes = {
    "html",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
  },
})

lspconfig.cssls.setup({
  filetypes = { "css", "scss", "less", "vue" },
})

lspconfig.ts_ls.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

vim.lsp.enable(servers)
