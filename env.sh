#!/bin/zsh

# Aliases
alias rm=trash
alias cat=ccat

# Functions
function mkcd() { mkdir -p "$@" && cd "$_"; }
