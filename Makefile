GO := go


# Linux command settings
FIND := find . ! -path './vendor/*'
XARGS := xargs -r

# ==============================================================================
# Build options

ROOT_PACKAGE := github.com/aboutprogramming/bingo


ifeq ($(origin ROOT_DIR),undefined)
ROOT_DIR := $(shell pwd)
endif


all: test fmt lint

## help: Show this help info.
.PHONY: help
help: Makefile
	@echo -e "\nUsage: make <TARGETS> ...\n\nTargets:"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo "$$USAGE_OPTIONS"

## test: Test the package.
.PHONY: test
test:
	@echo "===========> Testing packages"
	@$(GO) test $(ROOT_PACKAGE)/...

.PHONY: golines.verify
golines.verify:
ifeq (,$(shell which golines 2>/dev/null))
	@echo "===========> Installing golines"
	@$(GO) get -u github.com/segmentio/golines
endif

## fmt: Format the package with `gofmt`
.PHONY: fmt
fmt: golines.verify
	 @echo "===========> Formatting codes"
	 @$(FIND) -type f -name '*.go' | $(XARGS) gofmt -s -w
	 @$(FIND) -type f -name '*.go' | $(XARGS) goimports -w -local $(ROOT_PACKAGE)
	 @$(FIND) -type f -name '*.go' | $(XARGS) golines -w --max-len=120 --reformat-tags --shorten-comments --ignore-generated .


.PHONY: lint.verify
lint.verify:
ifeq (,$(shell which golangci-lint 2>/dev/null))
	@echo "===========> Installing golangci lint"
	@GO111MODULE=off $(GO) get -u github.com/golangci/golangci-lint/cmd/golangci-lint
endif

## lint: Check syntax and styling of go sources.
.PHONY: lint
lint: lint.verify
	@echo "===========> Run golangci to lint source codes"
	@golangci-lint run $(ROOT_DIR)/... -v -c .golangci.yml



