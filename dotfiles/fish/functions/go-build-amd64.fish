# build an amd64-linux go binary 

function go-build-amd64
    set -lx GOOS linux
    set -lx GOARCH amd64
    go build -ldflags="-s -w" $argv
end
