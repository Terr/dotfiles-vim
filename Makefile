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

RLS = ${HOME}/.rustup/toolchains/*/bin/rls
RUST_FMT = ${HOME}/.rustup/toolchains/*/bin/cargo-fmt
RUST_CLIPPY = ${HOME}/.rustup/toolchains/*/bin/cargo-clippy

all: youcompleteme ctags rls rust_fmt rust_clippy

youcompleteme:
	# Ensure YouCompleteMe is installed
	vim -c PlugInstall -c qa
	cd home/.vim/plugged/YouCompleteMe/ && \
		./install.py \
			--tern-complete

# Rust language server
rls: $(RLS)
$(RLS):
	rustup component add rls-preview rust-analysis rust-src

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
