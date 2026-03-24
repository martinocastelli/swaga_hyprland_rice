#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias cd='z'
alias lg='lazygit'
alias ls='eza'
alias ll='eza -lh --group-directories-first'
alias lls='eza -lh --total-size --group-directories-first'
alias la='eza -a'
alias clr_logo='clear;fastfetch'
alias clr_logo_dir='clear;fastfetch;eza -laih --total-size --group-directories-first'
alias grep='grep --color=auto'
alias tree='eza -lh --total-size --group-directories-first -T'
alias matrix='neo-matrix -D --charset=ascii'
alias minilogo='env PF_INFO="ascii" pfetch'
alias zen='zen-browser'
alias open='xdg-open'
alias pdf='bookokrat'
alias split_terminal='kitty --directory $(pwd) --detach'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

PS1="\[\e[31m\]\`nonzero_return\`\[\e[34m\]\W\[\e[m\]\[\e[35m\]\\$\[\e[m\] "

echo -ne "\033[31m"
figlet arch -f Sub-Zero
echo -ne "\033[0m"
fastfetch

. "$HOME/.local/bin/env"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

eval "$(atuin init bash --disable-up-arrow)"

eval "$(zoxide init bash)"


[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
