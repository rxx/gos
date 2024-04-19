default:
  @just --list --justfile {{justfile()}}

run cmd: build
  ./gos {{cmd}}

watch: build
  ./gos watch
  
fmt:
  go fmt ./...

update_deps:
  go list -m -u all

build:
  go build -o gos github.com/rxx/gos/cmd/gos
  
