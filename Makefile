SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --no-builtin-rules

NPROC ?= $(shell nproc --all)
# OS detection
OS := $(shell uname)
IS_MACOS = 0
IS_LINUX = 0
ifeq ($(OS), Darwin)
	IS_MACOS = 1
endif
ifeq ($(OS), Linux)
	IS_LINUX = 1
endif

PIP = pip3
PYLS = ${HOME}/.local/bin/pyls
RLS = ${HOME}/.rustup/toolchains/nightly*/bin/rls
RUST_FMT = ${HOME}/.rustup/toolchains/*/bin/cargo-fmt
RUST_CLIPPY = ${HOME}/.rustup/toolchains/*/bin/cargo-clippy
VIM = /usr/local/bin/vim
VIM_VERSION ?= 9.0.0014

all: vim ctags python rust
python: pyls
rust: rls rust_fmt rust_clippy

.PHONY: vim
vim:
ifeq ($(IS_MACOS), 1)
	brew upgrade vim || brew install vim
else
	@if [ -f "${VIM}" ]; then
		$(eval VIM_UPTODATE := $(shell vim --not-a-term --cmd "echo has('patch-${VIM_VERSION}')" --cmd qa 2>&1 1>/dev/null))
		@if [ ${VIM_UPTODATE} -eq 1 ]; then
			@echo 'vim version "${VIM_VERSION}" (or higher) already installed'
			@exit 0
		@fi
	@fi

	$(eval TMPDIR := $(shell mktemp --directory))
	cd "${TMPDIR}"
	curl -L https://github.com/vim/vim/archive/v"${VIM_VERSION}".tar.gz|tar zx
	cd vim-"${VIM_VERSION}"

	CFLAGS=-O3 ./configure \
		--disable-canberra \
		--disable-darwin \
		--disable-gpm \
		--disable-netbeans \
		--enable-cscope \
		--enable-gui=no \
		--enable-python3interp=yes \
		--enable-terminal \
		--with-compiledby='T E R R' \
		--with-python3-command=/usr/bin/python3 \
		--with-x 
	cd src
	make -j${NPROC}
	set -x
	sudo make install || su -c 'make install'
	set +x
	cd /
	rm -r "${TMPDIR}"
endif

.PHONY:
vim-dependencies:
	apt install -y \
		libncursesw5-dev \
		libpython3-dev \
		libx11-dev \
		libxt-dev \
		python3-distutils

.PHONY:
latest-vim-version:
	curl --silent https://api.github.com/repos/vim/vim/tags|jq '.[0]["name"]'|sed --regexp-extended 's/"v([^"]+)"/\1/g'

# Python language server
pyls: $(PYLS)
$(PYLS):
	${PIP} install --user python-language-server

# Rust language server
rls: $(RLS)
$(RLS):
	rustup component add rls-preview rust-analysis rust-src --toolchain nightly

rust_fmt: $(RUST_FMT)
$(RUST_FMT):
	rustup component add rustfmt-preview

rust_clippy: $(RUST_CLIPPY)
$(RUST_CLIPPY):
	rustup component add clippy-preview

ctags:
ifeq ($(IS_MACOS), 1)
	# Universal ctags
	brew install --HEAD universal-ctags 
	# GNU Global
	brew install global
endif
