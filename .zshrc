# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/martino/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ls='eza'
alias ll='eza -lh --total-size --group-directories-first'
alias la='eza -a'
alias clr_logo='clear;fastfetch'
alias clr_logo_dir='clear;fastfetch;eza -laih --total-size --group-directories-first'
alias grep='grep --color=auto'
alias tree='eza -lh --total-size --group-directories-first -T'
alias trash='mv -t ~/.trash'
alias matrix='neo -D --charset=ascii'

PS1="%{$(tput setaf 9)%}%(?..%? )%{$(tput setaf 12)%}%2~%{$(tput setaf 13)%}$ "
 
echo -ne "\033[31m"
figlet arch -f Sub-Zero
echo -ne "\033[0m"
fastfetch


. "$HOME/.local/bin/env"
