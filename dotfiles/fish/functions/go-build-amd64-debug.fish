# build an amd64-linux go binary 

function go-build-amd64-debug
    set -lx GOOS linux
    set -lx GOARCH amd64
    go build $argv
end
