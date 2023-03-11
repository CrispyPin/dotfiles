#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -hAGg'
alias ll='ls -Al'
alias pf='pfetch'
alias ff='fastfetch'
PS1='\e[38;2;40;255;180m\u\e[0m@\e[38;2;255;180;100m\h\e[0m \w> '

