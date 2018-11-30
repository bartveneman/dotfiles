#!/bin/zsh

export GPG_TTY=$(tty)

# Aliases
alias rm=trash
alias cat=bat
alias hr="hr '-'"
alias mag="bin/magento"
alias magento="bin/magento"
alias console="bin/console"
alias cons="bin/console"

# Functions
function mkcd() { mkdir -p "$@" && cd "$_"; }
