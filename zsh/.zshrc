#prompt config
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format "%K{magenta}%F{black} %d %k%%F{magenta}%K{black}%k%%f%"
zstyle ':completion:*:warnings' format "%K{red}%F{black} No matches found %k%%F{red}%K{black}%k%%f%"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_cd
setopt NO_BEEP


#alias
alias norm='norminette'
alias gccf='gcc -Wall -Werror -Wextra'
alias l='ls'
alias ll='ls -lh'
alias la='ls -lha'
alias gst='git status'
alias gco='git checkout'
alias gci='git commit'
alias grb='git rebase'
alias gbr='git branch'
alias gpl='git pull'
alias gpu='git push'
alias gad='git add -A'
alias gfe='git fetch'
alias gme='git merge'
alias gdf='git diff'
alias gc='git clone'
alias gre='git clone --recursive'
alias gbr="git branch | grep -v "master" | xargs git branch -D"
alias v='vim'
alias vc='vim -c "Stdheader"'
alias zr='source ~/.zshrc'
alias ...='cd ../..'
alias ....='cd ../../..'
alias o='open'
alias lock='/System/Library/CoreServices/Menu\ Extras/user.menu/Contents/Resources/CGSession -suspend'
alias firefox='open "/sgoinfre/goinfre/Perso/tglandai/Firefox Nightly.app"'
alias cleanlib='rm -rf ~/Library/*.42_cache_bak*'
alias cc++='clang++ -Wall -Wextra -Werror'
alias cc++98='clang++ -Wall -Wextra -Werror -std=c++98'
alias cpconf='cleanlib ; cp -R ~/Config/Firefox/Profiles/tglandai.default ~/Library/Application\ Support/Firefox/Profiles &; cp ~/Config/Firefox/profiles.ini ~/Library/Application\ Support/Firefox/profiles.ini &; cp -R ~/Config/Code/User ~/Library/Application\ Support/Code/'

#key bindings
bindkey	"^[[3~"		delete-char
bindkey	"^[3;5~"	delete-char
bindkey "^[[1;2C"	forward-word
bindkey "^[[1;2D"	backward-word
_zsh_cli_fg() {
    fg;
}
zle -N _zsh_cli_fg
bindkey	'^Z'		_zsh_cli_fg


#plugins
source ~/Config/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/Config/zsh/powerlevel9k/powerlevel9k.zsh-theme


#powerlevel9k config
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time context)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
prompt_context() {
    print -n "%F{cyan}\uE0B2%K{cyan}%F{black} %m "
}


#open visual studio code
if [ -e "/sgoinfre/goinfre/Perso/tglandai/Visual Studio Code.app" ]; then
    code() {
        open -a /sgoinfre/goinfre/Perso/tglandai/Visual\ Studio\ Code.app $1
    }
fi


#42 school
if [ $HOME = "/Users/tglandai" ]; then

    #brew path
    PATH=$HOME/.brew/bin:$PATH

    #export user
    USER=`/usr/bin/whoami`
    export USER
    GROUP=`/usr/bin/id -gn $USER`
    export GROUP
    MAIL="$USER@student.42.fr"
    export MAIL

    osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/tglandai/Config/background.jpg"'
fi


#show all ip
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}
