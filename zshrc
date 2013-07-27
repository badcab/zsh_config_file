#< ~/.art
zmodload zsh/complist
autoload -U compinit && compinit
setopt autocd

#fortune -s

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

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

#FreeBSD
#alias update='sudo portsnap fetch update && sudo portmanager -a && sudo freebsd-update fetch install'
#alias install='sudo pkg install'
#alias s_update=''

#Fedora
#export EDITOR=nano
#alias ee='nano'
#alias update='sudo yum -y update --skip-broken'
#alias install='sudo yum install'
#alias search='yum search'


#Debian Pi
export EDITOR=nano
alias ee='nano'
alias update='sudo apt-get update && sudo apt-get upgrade && sudo rpi-update'
alias install='sudo apt-get install'


alias zshrc='nano ~/.zshrc'
alias la='ls -a'
alias ll='ls -l'
alias irc='ninja'
alias screen='screen -R'
alias fixit='sudo tail -f -n 25 /var/log/httpd/error_log | grep 127.0.0.1'

alias clear='clear && source ~/.zshrc'
alias add='git add --all'
alias commit='git commit -a'
alias diverge='git lava diverge -b'
alias melt='git lava melt'
alias survey='git lava survey'
alias erupt='git lava erupt -d'
alias flow='git lava flow'
alias status='git status'
alias projectSize='git ls-files | xargs wc -l'

autoload -U colors && colors

# Stuff for git
parse_git_branch () {
    git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/ (\1)/g'
}

BLACK=$'\033[0m'
RED=$'\033[38;5;167m'
GREEN=$'\033[38;5;71m'
BLUE=$'\033[38;5;111m'
YELLOW=$'\033[38;5;228m'
ORANGE=$'\033[38;5;173m'

function precmd() {
    export PROMPT="%{$GREEN%}%~%{$YELLOW%}$(parse_git_branch)%{$RED%} pi> %{$GREEN%}"
}
