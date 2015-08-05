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
    PS1="\n\\[\e[00;37m\]\w\[\e[0m\]\n"

    #add a star if inside screen
    [ -n "$STY" ] && PS1+="\[\e[${S1};${S2}m\]★  \[\e[0m\]"

    #common prompt
    PS1+="\[\e[${U1};${U2}m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[${H1};${H2}m\]\h\[\e[0m\]"

    #green/red chevron depending on last exit code
    if [ $EXIT != 0 ]; then
        PS1+="\[\e[0;31m\] ❯ \[\e[0m\]"
    else
        PS1+="\[\e[0;32m\] ❯ \[\e[0m\]"
    fi

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

export EC2_HOME="/usr/local/ec2/ec2-api-tools-1.7.2.4"  
export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=1024m"
export PAGER=less
export LESS="-iMSx4 -FX"
export PROMPT_COMMAND=prompt_command
export DISABLE_AUTO_TITLE=true
export GOPATH=~/gocode

[ "$(hostname)" == "host56.starfishsolutions.com" ] && export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" 

PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
PATH="${HOME}/bin:${PATH}"
PATH="${EC2_HOME}/bin:${PATH}"
PATH="${HOME}/gocode/bin:${PATH}"
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export PATH=${PATH}

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

alias ls='ls -GFh'
alias grep='grep --color=auto'
alias flushdns='sudo killall -HUP mDNSResponder'
alias worklog='vim "+set wrap" -O "$HOME/Dropbox/Work/worklog/$(date +"%Y%m%d").txt" $(find $HOME/Dropbox/Work/worklog -type f -name *.txt ! -name "$(date +"%Y%m%d").txt" | sort | tail -1)'
alias worklog_search='find $HOME/Dropbox/Work/worklog -type f -name *.txt | percol'
alias mux='tmuxinator'

[ -r ~/bin/tmuxinator.bash ] && source ~/bin/tmuxinator.bash
