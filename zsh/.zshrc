# **************************************************************************** #
#                                                                              #
#                    ::::::::::  ::::::::  :::::::::  ::::::::::               #
#                   :+:        :+:    :+: :+:    :+: :+:    :+:                #
#                  +:+              +:+  +:+    +:+ +:+                        #
#                 +#++:++#       +#+    +#++:++#:  +#++:++#+                   #
#                +#+          +#+      +#+    +#+        +#+                   #
#               #+#         #+#       #+#    #+# #+#    #+#                    #
#              ########## ########## ###    ###  ########                      #
#                                                                              #
#                 .zshrc                                                       #
#                                                                              #
#                 By: tglandai <thibault.glandais@gmail.com>                   #
#                                                                              #
# **************************************************************************** #

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


case $TERM in
    xterm*)
        # If this is an xterm set the title to user@host:dir
        # precmd () {print -Pn "\e]0;%n@%m: %~\a"}

        # If this is an xterm set the title to dir
        precmd () {print -Pn "\e]0;%~\a"}
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#alias
alias l='ls'
alias ll='ls -lh'
alias la='ls -lha'

alias gst='git status'
alias gco='git checkout'
alias gce='git checkout'
alias gci='git commit'
alias grb='git rebase'
alias gbr='git branch'
alias gbrclean='git branch | grep -v "master" | xargs git branch -D'
alias gmergeclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gpl='git pull'
alias gpu='git push'
alias gad='git add -A'
alias gfe='git fetch'
alias gme='git merge'
alias gdf='git diff'
alias gc='git clone'
alias gre='git clone --recursive'
alias gl='git log'
alias gignorefolder='git ls-files -z | xargs -0 git update-index --assume-unchanged'

alias v='vim'
alias zr='source ~/.zshrc'
alias ...='cd ../..'
alias ....='cd ../../..'
alias o='xdg-open'
alias open='xdg-open'
alias dockerenv='eval $(docker-machine env)'
alias odsync='onedrive --synchronize'
alias npxw='npx webpack --mode=development'
alias gsubupdate='git submodule update --remote --merge'
alias gitinspector='python3 ~/gitinspector/gitinspector.py'
alias javaversion="sudo update-alternatives --config java"
alias ngroka='ngrok http 8080 -region=ap'

alias speedtest-cli='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias compress-picture='mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 85% *.PATH'

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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status context)
# prompt_context() {
#     print -n "%F{cyan}\uE0B2%K{cyan}%F{black} %n@`hostname -f`"
# }

source ~/Config/zsh/private.sh

#transfer.sh
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfersh.com/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfersh.com/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfersh.com/$file_name"|tee /dev/null;fi;}

export ANDROID_HOME="$HOME/Android/Sdk/"

# export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')

export PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools"
export PATH="$PATH:$HOME/Android/android-studio/bin"
export PATH="${PATH}:$HOME/.symfony/bin"
export PATH="$PATH:$HOME/Apps/flutter/bin"
export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/thibault/.config/composer/vendor/bin"

extract() {
    date=`date +%Y-%m-%d`
    if [ -n "$1" ]
    then
        commitId=$1
    else
        commitId=`git log --format="%H" -n 1`
    fi
    git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT $commitId | xargs tar -rf $date.tar
}

if [[ $TILIX_ID ]]; then
        source /etc/profile.d/vte.sh
fi

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

source <(cod init $$ zsh)
