# List all just tasks
default:
  @just --list --justfile {{justfile()}}

# Run scene with number in DEBUG mode
run_debug number: build_debug
  DEBUG=1 bin/gos run {{number}}

# Start server in DEBUG mode
start_debug: build_debug
  DEBUG=1 bin/gos start
  
# Run scene with number
run number: build
  bin/gos run {{number}}

# Start server
start: build
  bin/gos start
  
# Format, vet and test code
check: fmt vet test

# Check with golangci
ci:
  golangci run
  
# Format code (using goimports)
fmt: install_tools
  goimports -l -w .
  
# Run vet code analysis 
vet:
  go vet ./...
  
# Run tests with coverprofile
test:
  go test ./... -coverprofile=cover.out

# Run tests with race detector and coverprofile
test_race:
  go test ./... -race -coverprofile=cover.out

# open the interactive UI to check the Coverage Report
cover:
  go tool cover -html=cover.out
  
# Build with static linking and debug information 
build_debug: install tidy
  CGO_ENABLED=0 go build -o bin/gos github.com/rxx/gos/cmd/gos

# Build with static linking and strip debug info
build: install
  CGO_ENABLED=0 go build -o bin/gos -ldflags="-s -w" -trimpath github.com/rxx/gos/cmd/gos

# Make go.mod clean
tidy:
  go mod tidy
  
# Download dependencies
install:
  go mod download
  
# List dependencies and their latest versions
deps:
  go list -m -u all
  
# Install goimports
install_tools:
  go install golang.org/x/tools/cmd/goimports@latest
