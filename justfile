default:
  @just --list --justfile {{justfile()}}

run cmd: build
  ./gos {{cmd}}

watch: build
  ./gos watch
  
fmt:
  go fmt ./...

deps:
  go list -m -u all

tidy:
  go mod tidy

build:
  go build -o gos github.com/rxx/gos/cmd/gos
  
