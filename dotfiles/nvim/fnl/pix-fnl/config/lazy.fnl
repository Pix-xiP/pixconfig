;; boostrap lazy.nvim

(let [uv      (or vim.uv vim.loop)
      lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim")]

  (when (not (uv.fs_stat lazypath))
    (let [lazyrepo "https://github.com/folke/lazy.nvim.git"
          out (vim.fn.system ["git" "clone" "--filter=blob:none" "--branch=stable" lazyrepo lazypath])]
      (when (not= vim.v.shell_error 0)
        (vim.api.nvim_echo
          [["Failed to clone lazy.nvim:\n" "ErrorMsg"]
           [out "WarningMsg"]
           ["\nPress any key to exit..."]]
          true
          {})
        (vim.fn.getchar)
        (os.exit 1))))

  ;; ---@type vim.Option
  (vim.opt.rtp:prepend lazypath)

  ;; setup lazy.nvim for package management
  (let [lazy (require :lazy)]
    (lazy.setup
      {:spec 
				;; lets use LazyVim as a base?
        [["LazyVim/LazyVim" {:import "lazyvim.plugins"}]

        ;; load plugins etc here
        [{:import "plugins"}]
        [{:import "pix-fnl.plugins"}]
        ;; [{:import "pix"}]
        ]

       :dev {:path "~/AdeptusCustodes/Lunar/nvim_plugins"  ;; directory where local plugins ar stored
             ;; plugins that match these patterns will use your local version instead of the remote
             :patterns ["umbral"]                           ;; my theme <3
             ;; should you go looking to github if the local is missing?
             :fallback true}

       :defaults {:lazy false :version false} ;; always use the latest git commit

       :install {:colorscheme ["tokyonight" "habamax"]}

       :checker {:enabled true} ;; automatically check for plugin updates

       :performance {:rtp {:disabled_plugins 
														["gzip"
														 "tarPlugin"
														 "tohtml"
														 "tutor"
														 "zipPlugin"]}}}))
)
