# Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/Projects/go
export GOBIN=$GOPATH/bin
export GOCI=/usr/local/go-ci
export GOLANGCI_LINT_VERSION=1.20.0
export GO111MODULE=on
export GOSUMDB=off
export GOPRIVATE=gitlab.frg.tech,jaxf-github.fanatics.corp
export PATH=$PATH:$GOROOT:$GOBIN:$GOPATH

# JQ
export JQ_COLORS='0;33:0;35:0;35:0;34:0;32:0;36:0;36'

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Python Poetry
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# dotfiles
alias config='/usr/bin/git --git-dir=/Users/swade/.dotfiles/ --work-tree=/Users/swade'
