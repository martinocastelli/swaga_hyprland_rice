#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza'
alias ll='eza -lh --total-size --group-directories-first'
alias la='eza -a'
alias clr_logo='clear;fastfetch'
alias clr_logo_dir='clear;fastfetch;eza -laih --total-size --group-directories-first'
alias grep='grep --color=auto'
alias tree='eza -lh --total-size --group-directories-first -T'
alias trash='mv -t ~/.trash'

PS1="\[\e[36m\]\w\[\e[m\]\\$ "

echo -ne "\033[31m"
figlet arch -f Sub-Zero
echo -ne "\033[0m"
fastfetch
