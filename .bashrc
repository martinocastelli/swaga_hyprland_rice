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
alias matrix='neo-matrix -D --charset=ascii'
alias minilogo='env PF_INFO="ascii" pfetch'
alias zen='zen-browser'
alias open='xdg-open'

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[34m\]\w\[\e[m\]\[\e[35m\]\\$\[\e[m\] "

echo -ne "\033[31m"
figlet arch -f Sub-Zero
echo -ne "\033[0m"
fastfetch

. "$HOME/.local/bin/env"
