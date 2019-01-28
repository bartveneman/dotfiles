#!/bin/zsh

export GPG_TTY=$(tty)
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Aliases
alias rm=trash
alias cat=bat

# Functions
function mkcd() { mkdir -p "$@" && cd "$_"; }
