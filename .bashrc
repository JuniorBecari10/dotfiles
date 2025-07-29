#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ll='ls -la'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'

# (user) folder $

# Example:
# (antonio) ~ $
PS1='\[\e[1;36m\](\u)\[\e[0m\] \[\e[1;32m\]\w\[\e[0m\] \$ '
