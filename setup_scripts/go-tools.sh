#!/bin/bash -ex

# Development
go install github.com/air-verse/air@latest                            # live reload
go install github.com/go-delve/delve/cmd/dlv@latest                   # Go debugger
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest # Linting!
go install github.com/segmentio/golines@latest                        # Shorten longass lines
go install golang.org/dl/gotip@latest                                 # Get the latest version of go :>
go install golang.org/x/tools/cmd/deadcode@latest                     # find dead code
go install golang.org/x/tools/cmd/godoc@latest                        # Documentation
go install golang.org/x/tools/gopls@latest                            # language server
go install gotest.tools/gotestsum@latest                              # Testing
go install mvdan.cc/gofumpt@latest                                    # stricter code formatting

# General tools
go install github.com/Owloops/updo@latest         # check if something is online!
go install github.com/charmbracelet/freeze@latest # Screenshot your code :>
go install github.com/dhth/omm@latest             # On my mind todo app
go install github.com/dim-an/cod@latest           # Code completion on anything
go install github.com/TypicalAM/goread@latest     # RSS Reader

go install github.com/projectdiscovery/simplehttpserver/cmd/simplehttpserver@latest # Replacement for updog
