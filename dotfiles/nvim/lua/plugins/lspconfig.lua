return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        bashls = {
          cmd = { "bash-language-server", "start" },
          filetypes = { "sh" },
          settings = {
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command)",
            },
          },
        },
        clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "h", "cpp", "hpp" },
        },
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          rootPatterns = { "go.work", "go.mod", ".git" },
          gofumpt = true, -- Enable gofumpt formatting
          settings = {
            analyses = {
              unusedparams = true,
              staticcheck = true,
            },
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
            semanticTokens = true,
          },
        },

        lua_ls = {
          settings = {
            -- Remove the missing 'vim' from neovim config files :>
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        -- ols = {
        --   cmd = { "ols" },
        --   filetypes = { "odin" },
        --   rootPatterns = { "ols.json", ".git" },
        --   init_options = {
        --     enable_format = true,
        --     enable_hover = true,
        --     enable_document_symbols = true,
        --     -- enable_semantic_tokens = true, -- Don't want highlighting
        --     enable_inlay_hints = true,
        --     enable_snippets = false,
        --     enable_references = true,
        --     enable_rename = true,
        --     enable_label_details = true,
        --   },
        -- },
        -- omnisharp = {
        --   cmd = { "omnisharp" },
        --   enable_editorconfig_support = true,
        --   enable_ms_build_load_projects_on_demand = false,
        --   -- Enables support for roslyn analyzers, code fixes and rulesets.
        --   enable_roslyn_analyzers = true,
        --   organize_imports_on_format = true,
        --   enable_import_completion = true,
        --   sdk_include_prereleases = true,
        --   analyze_open_documents_only = false,
        --   filetypes = { "cs", "vb" },
        --   init_options = {},
        --   rootPatterns = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
        --   -- For go-to-definition functionality and decompliatino you require omnisharp-extended.
        --   handlers = {
        --     ["textDocument/definition"] = function(...)
        --       return require("omnisharp_extended").handler(...)
        --     end,
        --   },
        --   keys = {
        --     {
        --       "gd",
        --       function()
        --         require("omnisharp_extended").telescope_lsp_definitions()
        --       end,
        --       desc = "Goto Definition",
        --     },
        --   },
        -- },
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift" },
          rootPatterns = { "compile_commands.json", "Package.swift", ".git" },
          opts = {
            capabilities = {
              workspace = {
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              },
            },
          },
        },
        zls = {
          cmd = { "zls" },
          filetypes = { "zig" },
          single_file_support = true,
        },
      },
    },
  },
  --  --  To make omnisharp not trash
  --  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

  {
    "stevearc/conform.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      -- Leader, Code, Format
      {
        "<leader>cF",
        mode = { "n", "v" },
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        desc = "Format injected languages from lsp",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        c = { "clang-format" },
        odin = { "odinfmt" },
        swift = { "swift_format" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- Formatting for Swift since nothing built in x(
        swift_format = {
          command = "swift-format",
          args = { "--configuration", "/Users/pix/.config/formatting/swift-config.json" },
          stdin = true,
        },
      },
    },
  },
}
