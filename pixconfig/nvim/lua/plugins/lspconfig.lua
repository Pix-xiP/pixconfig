-- Adding Sourckit to LSP list?
--

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = { "clangd" },
        filetypes = { "c", "h", "cpp", "hpp" },
      },
      sourcekit = {
        cmd = { "sourcekit-lsp" },
        filetypes = { "swift" },
      },
      ols = {
        cmd = { "ols" },
        filetypes = { "odin" },
        rootPatterns = { "ols.json", ".git" },
        init_options = {
          enable_format = true,
          enable_hover = true,
          enable_document_symbols = true,
          -- enable_semantic_tokens = true, // Don't want highlighting
          enable_inlay_hints = true,
          enable_snippets = false,
          enable_references = true,
          enable_rename = true,
          enable_label_details = true,
        },
      },
    },
  },
}
