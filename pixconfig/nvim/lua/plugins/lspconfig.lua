-- LSP configuration goes here :>
return {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
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
            -- enable_semantic_tokens = true, -- Don't want highlighting
            enable_inlay_hints = true,
            enable_snippets = false,
            enable_references = true,
            enable_rename = true,
            enable_label_details = true,
          },
        },
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          rootPatterns = { "go.work", "go.mod", ".git" },
        },
        zls = {
          cmd = { "zls" },
          filetypes = { "zig" },
          single_file_support = true,
        },
        omnisharp = {
          cmd = { "omnisharp" },
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
          -- Enables support for roslyn analyzers, code fixes and rulesets.
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          sdk_include_prereleases = true,
          analyze_open_documents_only = false,
          filetypes = { "cs", "vb" },
          init_options = {},
          rootPatterns = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
          -- For go-to-definition functionality and decompliatino you require omnisharp-extended.
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
        },
      },
    },
    {
      "stevearc/conform.nvim",
      opts = {
        formatters = {
          swift_format = {
            command = "swift-format",
            args = { "--configuration", "/Users/pix/.config/formatting/swift-config.json" },
            stdin = true,
          },
        },
        formatters_by_ft = {
          swift = { "swift_format" },
        },
      },
    },
  },
}
