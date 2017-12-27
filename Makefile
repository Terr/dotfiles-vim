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


all: ctags python-language-server

ctags:
ifeq ($(IS_MACOS), 1)
	# Universal ctags
	brew install --HEAD universal-ctags 
	# GNU Global
	brew install global
endif

PIP := $(shell command -v pip3 2>/dev/null)
ifndef PIP
	PIP = $(shell command -v pip 2>/dev/null)
endif
python-language-server:
	$(PIP) install --user python-language-server==0.11.1

