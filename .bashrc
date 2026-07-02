# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias t='true'
alias v='vim'
if command -v lazygit > /dev/null 2>&1; then
	alias lg='lazygit'
fi
if command -v eza > /dev/null 2>&1; then
	alias ls='eza'
	alias ll='eza -lh --icons --group-directories-first'
	alias lla='eza -lha --icons --group-directories-first'
	alias lls='eza -lh --icons --total-size --sort=size'
	alias lli='eza -lhaH --total-size --group-directories-first --time-style=long-iso --time=accessed --git'
	alias la='eza -a'
	alias tree='eza -lh --icons -T'
fi
if command -v fastfetch > /dev/null 2>&1; then
	if fastfetch -c config_small > /dev/null 2>&1; then
		alias smallfetch='fastfetch -c config_small'
	fi
	alias clr_logo='clear;fastfetch'
	alias clr_logo_dir='clear;fastfetch;eza -lih --group-directories-first;pwd'
fi
alias grep='grep --color=auto'
if command -v fastfetch > /dev/null 2>&1; then
	alias matrix='neo-matrix -D --charset=ascii'
fi 
if command -v pfetch > /dev/null 2>&1; then
	alias minilogo='env PF_INFO="ascii" pfetch'
fi
if command -v zen-browser > /dev/null 2>&1; then
	alias zen='zen-browser'
fi
alias open='xdg-open'
if command -v kitty > /dev/null 2>&1; then
	alias split_term='kitty --directory $(pwd) --detach'
fi
alias ..='cd ..'
#manage trash cli
if command -v trash > /dev/null 2>&1; then
	alias rm='echo -e "!!!use trash-cli!!!\n(trsh)";false'
	alias trsh='trash-put'
fi

if command -v yazi > /dev/null 2>&1; then
	function y() {
		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		command yazi "$@" --cwd-file="$tmp"
		IFS= read -r -d '' cwd < "$tmp"
		[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
		\rm -f -- "$tmp"
	}
fi

if command -v starship > /dev/null 2>&1; then
	export STARSHIP_CONFIG=~/.config/starship/config.toml
	eval "$(starship init bash)"
else
	function nonzero_return() {
		RETVAL=$?
		[ $RETVAL -ne 0 ] && echo "$RETVAL "
	}
	PS1="\[\e[31m\]\`nonzero_return\`\[\e[34m\]\W\[\e[m\]\[\e[35m\]\\$\[\e[m\] "
fi

# set the env vars
export EDITOR=vim
export VISUAL=vim
export TERMINAL=kitty
export XDG_HOME=/home/martino
export XDG_CONFIG_HOME=/home/martino/.config
export SUDO_PROMPT="$(tput setaf 4 bold)[sudo]$(tput sgr0) $(tput setaf 6)whats the magic word?$(tput sgr0) "

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
if command -v fzf > /dev/null 2>&1; then
	eval "$(fzf --bash)"
fi

if command -v zoxide > /dev/null 2>&1; then
	eval "$(zoxide init --cmd cd bash)"
fi

if command -v thefuck > /dev/null 2>&1; then
	eval "$(thefuck --alias fk)"
fi

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

if (($COLUMNS >= 80 && $LINES >= 15)); then
	if figlet arch -f Sub-Zero > /dev/null 2>&1; then
		echo -ne "\033[31m"
		figlet arch -f Sub-Zero
		echo -ne "\033[0m"
	fi
	if command -v smallfetch > /dev/null 2>&1; then
		smallfetch
	fi
fi
