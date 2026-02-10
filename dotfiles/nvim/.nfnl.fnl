; (print "Hello world from the nfnl config")

(local core (require :nfnl.core))
(local config (require :nfnl.config))
(local default (config.default))

{:source-file-patterns (core.concat default.source-file-patterns ["fnl/**/*.fnl"])}

