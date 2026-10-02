#!/bin/bash -e
# ##############################################################################
# Remal Linux Aliases
#
# Description: A collection of optimized shell aliases.
# Usage:       Source this script directly, or copy its contents into your
#              ~/.bashrc or ~/.zshrc file.
#
# Release:     0.0.1
# Author:      arnold.somogyi@gmail.com
# ##############################################################################
alias li="docker image ls | (sed -u 1q; sort -n -k1)"
alias lc="docker ps -a"
alias rmc='yes | docker container prune'
alias rmi='docker volume rm $(docker volume ls -qf dangling=true) ; docker rmi $(docker image ls -qf dangling=true)'
alias lv='docker volume ls'
alias rmv='docker volume prune -a'
alias dc='docker container rm $(docker ps -a -q)'
alias cs='docker container stop $(docker ps -a -q)'
