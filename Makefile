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


all: youcompleteme ctags

youcompleteme:
	# Ensure YouCompleteMe is installed
	vim -c PlugInstall -c qa
	cd home/.vim/plugged/YouCompleteMe/ && \
		./install.py \
			--tern-completer \
			--racer-completer

ctags:
ifeq ($(IS_MACOS), 1)
	# Universal ctags
	brew install --HEAD universal-ctags 
	# GNU Global
	brew install global
endif
