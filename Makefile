SHELL := bash
SHELLFLAGS := -eu -o pipefail -c
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

COC_EXTENSIONS_DIR := $(HOME)/.config/coc/extensions
PYTHON3 := /usr/bin/python3
VIM := /usr/local/bin/vim
VIM_VERSION ?= 9.1.1076

all: vim vim-plugins coc-extensions

.PHONY: vim coc-extensions latest-vim-version

.ONESHELL:
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
		--with-python3-command=${PYTHON3} \
		--with-x 
	cd src
	make -j${NPROC}
	set -x
	sudo make install || su -c 'make install'
	set +x
	cd /
	rm -r "${TMPDIR}"
endif

.SILENT:
latest-vim-version:
	curl --silent https://api.github.com/repos/vim/vim/tags|jq '.[0]["name"]'|sed --regexp-extended 's/"v([^"]+)"/\1/g'

vim-plugins:
	vim +PlugInstall +PlugUpdate +qa

coc-extensions: coc-rust-analyzer

coc-basedpyright: $(COC_EXTENSIONS_DIR)/node_modules/coc-basedpyright/package.json
$(COC_EXTENSIONS_DIR)/node_modules/coc-basedpyright/package.json:
	vim +"CocInstall -sync coc-basedpyright" +qa

coc-rust-analyzer: $(COC_EXTENSIONS_DIR)/node_modules/coc-rust-analyzer/package.json
$(COC_EXTENSIONS_DIR)/node_modules/coc-rust-analyzer/package.json:
	vim +"CocInstall -sync coc-rust-analyzer" +qa
