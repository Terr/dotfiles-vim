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

RLS = ${HOME}/.cargo/bin/rls
RUST_FMT = ${HOME}/.cargo/bin/cargo-fmt
RUST_CLIPPY = ${HOME}/.cargo/bin/cargo-clippy
VIM = /usr/local/bin/vim
VIM_VERSION ?= 8.1.0608

all: vim youcompleteme ctags rust
rust: rls rust_fmt rust_clippy

vim: $(VIM)
.ONESHELL:
$(VIM):
	$(eval TMPDIR := $(shell mktemp --directory))
	cd ${TMPDIR}
	curl -L https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz|tar zx
	cd vim-${VIM_VERSION}
	
	sudo apt install -y \
		libncursesw5-dev \
		libpython3-dev \
		libx11-dev \
		libxt-dev \
		python3-distutils
	./configure \
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
	#cd src
	#make -j${NPROC}
	#sudo make install
	#cd /
	#rm -rf ${TMPDIR}

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
