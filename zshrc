#Edit ~/.zsh_include to add aliases
#Edit ~/.art to make a motd type thing

#first run notes
#chsh -s $(which zsh)
#zsh screen php5 git wget ccrypt sudo nano 
 
zmodload zsh/complist
autoload -U compinit && compinit
setopt autocd
autoload -U colors && colors

zstyle 'completion:::::' completer _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:descriptions' format "-%d -"
zstyle ':completion:*:corrections' format "-%d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

touch ~/.zsh_include
touch ~/.art
touch ~/.histfile

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

#Alt-S inserts "sudo " at the start of line:
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

random(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c 64; echo; }

SYSTEM_TYPE='FEDORA'
BLACK=$'\033[0m'
RED=$'\033[38;5;167m'
GREEN=$'\033[38;5;71m'
BLUE=$'\033[38;5;111m'
YELLOW=$'\033[38;5;228m'
ORANGE=$'\033[38;5;173m'

if [[ "$SYSTEM_TYPE" = "FREEBSD" ]]; then
	export EDITOR=ee
	alias ei='ee -i'
	alias update='sudo portsnap fetch update && sudo freebsd-update fetch install && sudo portmaster -a'
	alias install='sudo pkg install'
	alias s_update='sudo svn up /usr/src'
elif [[ "$SYSTEM_TYPE" = "FEDORA" ]]; then
	export EDITOR=nano
	alias ee='nano'
	alias nano='nano -i'
	alias update='sudo dnf -y update --skip-broken --best --allowerasing'
	alias install='sudo dnf install'
	alias search='dnf search'
elif [[ "$SYSTEM_TYPE" = "DEBIAN_PI" ]]; then
	export EDITOR=nano
	alias ee='nano'
	alias nano='nano -i'
	alias update='sudo apt-get update && sudo apt-get upgrade && sudo rpi-update'
	alias install='sudo apt-get install'
fi

#general aliases
alias zshrc="$EDITOR ~/.zshrc"
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -l --color'
alias screen='screen -R'
alias fixit='sudo tail -f -n 25 /var/log/httpd/error_log | grep 127.0.0.1'
alias clear='clear && source ~/.zshrc'
alias sudi='sudo -i'

# Stuff for git
alias add='git add --all'
alias commit='git commit -a'
alias status='git status'
alias projectSize='git ls-files | xargs wc -l'
alias branch='git branch'


parse_git_branch () { git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/ (\1)/g' }

function precmd() { export PROMPT="%{$GREEN%}%~%{$YELLOW%}$(parse_git_branch)%{$RED%}> %{$GREEN%}" }

$(which cat) ~/.art
$(which fortune) -s 2> /dev/null
source ~/.zsh_include
