DIR := ${CURDIR}

E:=@
ifeq ($(V),1)
	E=
endif

cyan := $(shell which tput > /dev/null && tput setaf 6 2>/dev/null || echo "")
reset := $(shell which tput > /dev/null && tput sgr0 2>/dev/null || echo "")
bold  := $(shell which tput > /dev/null && tput bold 2>/dev/null || echo "")

.PHONY: default all help

default: build

help:
	@echo "$(bold)Usage:$(reset) make $(cyan)<target>$(reset)"
	@echo
	@echo "$(bold)Build:$(reset)"
	@echo "  $(cyan)build$(reset)                                 - build all charts (default)"
	@echo
	@echo "$(bold)Lint:$(reset)"
	@echo "  $(cyan)lint$(reset)                                  - lint the code and markdown files"
	@echo "  $(cyan)lint-code$(reset)                             - lint the code"
	@echo "  $(cyan)lint-md$(reset)                               - lint markdown files"
	@echo
	@echo "For verbose output set V=1"
	@echo "  for example: $(cyan)make V=1 build$(reset)"

# Used to force some rules to run every time
FORCE: ;

############################################################################
# OS/ARCH detection
############################################################################
os1=$(shell uname -s)
os2=
ifeq ($(os1),Darwin)
os1=darwin
os2=osx
else ifeq ($(os1),Linux)
os1=linux
os2=linux
else ifeq (,$(findstring MYSYS_NT-10-0-, $(os1)))
os1=windows
os2=windows
else
$(error unsupported OS: $(os1))
endif

arch1=$(shell uname -m)
ifeq ($(arch1),x86_64)
arch2=amd64
else ifeq ($(arch1),aarch64)
arch2=arm64
else ifeq ($(arch1),arm64)
arch2=arm64
else
$(error unsupported ARCH: $(arch1))
endif

############################################################################
# Vars
############################################################################

build_dir := $(DIR)/.build/$(os1)-$(arch1)

markdown_lint_version = v0.32.2
markdown_lint_image = ghcr.io/igorshubovych/markdownlint-cli:$(markdown_lint_version)

# There may be more than one tag. Only use one that starts with 'v' followed by
# a number, e.g., v0.9.3.
git_tag := $(shell git tag --points-at HEAD | grep '^v[0-9]*')
git_hash := $(shell git rev-parse --short=7 HEAD)
git_dirty := $(shell git status -s)

# The following vars are used in rule construction
comma := ,
null  :=
space := $(null) #

#############################################################################
# Utility functions and targets
#############################################################################

.PHONY: git-clean-check

tolower = $(shell echo $1 | tr '[:upper:]' '[:lower:]')

git-clean-check:
ifneq ($(git_dirty),)
	git diff
	@echo "Git repository is dirty!"
	@false
else
	@echo "Git repository is clean."
endif

############################################################################
# Determine go flags
############################################################################

#############################################################################
# Build Targets
#############################################################################

.PHONY: build

build:
	@echo "TODO: build doesn't do anything yet"

#############################################################################
# Code cleanliness
#############################################################################

lint: lint-code lint-md

lint-code:
	@echo "TODO: lint-code doesn't do anything yet"

lint-md:
	@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	@echo "!!! Linting rules for markdown are currently wrong. There was a discussion in the following PR related to changing the Markdown linting rules to allow for long lines."
	@echo "!!! PR https://github.com/spiffe/spire/pull/3494#pullrequestreview-1155095225"
	@echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	$(E)docker run --rm -v "$(DIR):/workdir" $(markdown_lint_image) "**/*.md"

#############################################################################
# Developer support
#############################################################################


#############################################################################
# Toolchain
#############################################################################
