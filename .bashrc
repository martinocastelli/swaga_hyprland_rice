# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias cd='z'
alias lg='lazygit'
alias ls='eza'
alias ll='eza -lh --group-directories-first'
alias lla='eza -lha --group-directories-first'
alias lls='eza -lh --total-size --group-directories-first'
alias la='eza -a'
alias clr_logo='clear;fastfetch'
alias clr_logo_dir='clear;fastfetch;eza -laih --total-size --group-directories-first;pwd'
alias grep='grep --color=auto'
alias tree='eza -lh --total-size --group-directories-first -T'
alias matrix='neo-matrix -D --charset=ascii'
alias minilogo='env PF_INFO="ascii" pfetch'
alias zen='zen-browser'
alias open='xdg-open'
alias pdf='bookokrat'
alias split_term='kitty --directory $(pwd) --detach'
alias fzfcd='cd $(find . -type d | fzf)'
#manage trash cli
alias rm='echo -e "!!!use trash-cli!!!\n(trsh)";false'
alias trsh='trash-put'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	\rm -f -- "$tmp"
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

PS1="\[\e[31m\]\`nonzero_return\`\[\e[34m\]\W\[\e[m\]\[\e[35m\]\\$\[\e[m\] "

# set the env vars
export EDITOR=vim
export VISUAL=vim

# https://gist.github.com/bahamas10/542875bb47990933638d2b7dfaa501bf
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
export GROFF_NO_SGR=1
export MANPAGER='less'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

eval "$(atuin init bash --disable-up-arrow)"

eval "$(zoxide init bash)"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

if (($COLUMNS >= 62 && $LINES >= 15)); then
	echo -ne "\033[31m"
	figlet arch -f Sub-Zero
	echo -ne "\033[0m"
	fastfetch
fi
