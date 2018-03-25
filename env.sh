#!/bin/zsh

# Aliases
alias rm=trash
alias cat=ccat
alias hr="hr '-'"

# Functions
function mkcd() { mkdir -p "$@" && cd "$_"; }
