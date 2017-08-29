COLOR_TYPES=(00 01)
COLOR_CODES=(31 32 33 34 35 36)

U1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
U2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
H1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
H2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
S1=${COLOR_TYPES[$RANDOM % ${#COLOR_CODES[@]} ]}
S2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}

function gibberish () {
    base64 /dev/urandom | head -c $@
}

function pretty () {
    local RESET='\e[0m'

    while read -r LINE; do
        local OUT=''
        local COLORNUM=31

        for COLUMN in ${LINE}; do
            local COLOR="\\e[0;${COLORNUM}m"
            COLORNUM=$((COLORNUM + 1))
            OUT="${OUT}${COLOR}${COLUMN}${RESET}\t"
        done

        echo -e "${OUT}"
    done <<< "$(cat -)" 
}

function renametab () {
    echo -ne "\033]0;"$@"\007"
}

function prompt_command () {
    local EXIT="$?"             # This needs to be first

    #first line
    PS1="\n\w\n"

    #add a star if inside screen
    [ "$TERM" == "screen" ] || [ "$TERM" == "screen-256color" ] && PS1+="\[\e[${S1};${S2}m\]★  \[\e[0m\]"

    #common prompt
    PS1+="\[\e[${U1};${U2}m\]\u\[\e[0m\]@\[\e[${H1};${H2}m\]\h\[\e[0m\]"

    #green/red chevron depending on last exit code
    if [ $EXIT != 0 ]; then
        PS1+="\[\e[0;31m\] ❯ \[\e[0m\]"
    else
        PS1+="\[\e[0;32m\] ❯ \[\e[0m\]"
    fi

}

function rename() {
    local NAME=$1

    if [ -n "${TMUX}" ]; then
        tmux rename-window "${NAME}"
    fi

    if [ "$TERM" == "screen" ] || [ "$TERM" == "screen-256color" ]; then
        screen -X title "${NAME}"
    fi
}

function port() {
    local PORT=$1

    lsof -i:$PORT | grep LISTEN
}

# put timestamps in bash history
export HISTTIMEFORMAT='%F %T '
# don't put duplicate commands into the history
export HISTCONTROL=ignoredups
# record only the most recent duplicated command (see above)
export HISTCONTROL=ignoreboth
export HISTIGNORE='pwd:ls:history:'
export HISTSIZE=4096
export EDITOR='vim'
export VISUAL='vim'
export AUTOSSH_POLL=30

export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=1024m"
export PAGER=less
export LESS="-iMSx4 -FX"
export PROMPT_COMMAND=prompt_command
export DISABLE_AUTO_TITLE=true
export GOPATH=~/gocode

PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/Dropbox/bin:${PATH}"
PATH="${HOME}/gocode/bin:${PATH}"
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
PATH="/opt/cisco/anyconnect/bin:${PATH}"
PATH="/opt/X11/bin:${PATH}"
export PATH=${PATH}

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

#fzf
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

alias ls='ls -GFh'
alias grep='grep --color=auto'
alias aria2c='aria2c -x 16'
alias flushdns='sudo killall -HUP mDNSResponder'
alias worklog='nvim "+set wrap" -O "$HOME/Dropbox/Work/worklog/$(date +"%Y%m%d").txt" $(find $HOME/Dropbox/Work/worklog -type f -name *.txt ! -name "$(date +"%Y%m%d").txt" | sort | tail -1)'
alias random_file='ls -R | sort -R | tail -1'
alias p.history='eval $(history | cut -c 28- | percol)'
alias p.checkout='git checkout $(git branch | percol | grep -Eo 'ME.*')'
alias p.push='git push -u origin $(git branch | percol | grep -Eo 'ME.*')'
alias p.nvim='nvim $(find ~/Workspace -type f | percol)'
alias git.addnw='git diff -U0 -w --no-color "$@" | git apply --cached --ignore-whitespace --unidiff-zero -'

#python3 stuff flips out without these set
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
