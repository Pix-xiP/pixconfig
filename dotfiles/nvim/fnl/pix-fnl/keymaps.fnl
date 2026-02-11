(local map vim.keymap.set)
; (local del vim.keymap.del)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

;; diagnostics 
(map ["n"] "<leader>q" vim.diagnostic.setloclist {:desc "open diagnostic [Q]uickfix list"})

;; move between windows with hjkl
(map ["n"] "<C-h>" "<C-w><C-h>" {:desc "move focus to left window"})
(map ["n"] "<C-j>" "<C-w><C-j>" {:desc "move focus to below window"})
(map ["n"] "<C-k>" "<C-w><C-k>" {:desc "move focus to above window"})
(map ["n"] "<C-l>" "<C-w><C-l>" {:desc "move focus to right window"})

;; resize windows with arrow keys 
(map ["n"] "<C-Up>" "<cmd>resize +2<cr>" {:desc "increase window height"})
(map ["n"] "<C-Down>" "<cmd>resize -2<cr>" {:desc "decrease window height"})
(map ["n"] "<C-Left>" "<cmd>vertical resize -2<cr>" {:desc "decrease window width"})
(map ["n"] "<C-Right>" "<cmd>vertical resize +2<cr>" {:desc "increase window width"})

;; move a single line up/down
(map ["n"] "<M-up>" "<cmd>m-2<cr>" {:desc "move line UP"})
(map ["n"] "<M-down>" "<cmd>m+2<cr>" {:desc "move line DOWN"})
(map ["i"] "<M-up>" "<esc><cmd>m .-2<cr>==gi" {:desc "move line UP"})
(map ["i"] "<M-down>" "<esc><cmd>m .+1<cr>==gi" {:desc "move line DOWN"})

;; move a selection up/down
(map ["v"] "<M-up>" ":m '<-2<CR>gv=gv" {:desc "move selection UP"})
(map ["v"] "<M-down>" ":m '>+1<CR>gv=gv" {:desc "move selection DOWN"})

;; clear search with <esc>
(map ["i" "n"] "<esc>" "<cmd>noh<cr><esc>" {:desc "clear search"})

;; sane behaviour for n and N. n - always forward, N - always backward
(map ["n"] "n" "'Nn'[v:searchforward].'zv'" {:expr true :desc "next search result"})
(map ["x"] "n" "'Nn'[v:searchforward]" {:expr true :desc "next search result"})
(map ["o"] "n" "'Nn'[v:searchforward]" {:expr true :desc "next search result"})
(map ["n"] "N" "'nN'[v:searchforward].'zv'" {:expr true :desc "previous search result"})
(map ["x"] "N" "'nN'[v:searchforward]" {:expr true :desc "previous search result"})
(map ["o"] "N" "'nN'[v:searchforward]" {:expr true :desc "previous search result"})

;; better indentation with g 
(map ["v"] "<" "<gv")
(map ["v"] ">" ">gv")

;; J but cursor says in current pos 
(map ["n"] "J" "mzJ`z" {:desc "join lines without cursor change"})

;; n/ N but cursor stays in center of screen
(map ["n"] "n" "nzzzv" {:desc "next search result"})
(map ["n"] "N" "Nzzzv" {:desc "previous search result"})

;; replace word under cursor 
(map ["n"] "<leader>xr" ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" {:desc "replace current word"})
(map ["v"] "<leader>xr" ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" {:desc "replace current word (scoped)"})

;; convert camelCase to snake_case
(map ["v"] "<leader>psc" ":s/[a-z]\\@<=[A-Z]/\\_\\l\\0/g<CR>" {:desc "convert camelCase to snake_case"})

;; empty return so we don't return a random map
{}
