COLOR_TYPES=(00 01)
COLOR_CODES=(31 32 33 34 35 36)

U1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
U2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
H1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
H2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
S1=${COLOR_TYPES[$RANDOM % ${#COLOR_CODES[@]} ]}
S2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}

gibberish() {
    base64 /dev/urandom | head -c $@
}

pretty() {
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

renametab() {
    echo -ne "\033]0;"$@"\007"
}

prompt_command() {
    local EXIT="$?"             # This needs to be first

    #first line
    PS1="\n\w\n"

    #common prompt
    PS1+="\[\e[${U1};${U2}m\]\u\[\e[0m\]@\[\e[${H1};${H2}m\]\h\[\e[0m\]"

    #green/red chevron depending on last exit code
    if [ $EXIT != 0 ]; then
        PS1+="\[\e[0;31m\] ❯ \[\e[0m\]"
    else
        PS1+="\[\e[0;32m\] ❯ \[\e[0m\]"
    fi

}

rename() {
    local NAME=$1

    if [ -n "${TMUX}" ]; then
        tmux rename-window "${NAME}"
    else
        screen -X title "${NAME}"
    fi
}

port() {
    local PORT=$1; lsof -i:$PORT | grep LISTEN
}

worklog() {
    local yesterday
    local today

    yesterday=$(find ~/cj_worklog -type f -name *.txt ! -name "$(date +'%Y%m%d').txt" | sort | tail -1)
    today=~/cj_worklog/$(date +'%Y%m%d').txt

    echo "Opening worklog..."

    if [[ ! -e "${today}" ]]; then
        echo "##################################" >> "${today}"
        echo "#        MORNING CHECKLIST       #" >> "${today}"
        echo "##################################" >> "${today}"
        echo "# Reply to mentions: " >> "${today}"
        echo "#---------------------------------" >> "${today}"
        echo "# Inspect alerts: " >> "${today}"
        echo "#---------------------------------" >> "${today}"
        echo "# Look for JIRA changes: " >> "${today}"
        echo "#---------------------------------" >> "${today}"
        echo "# Check Jenkins health: " >> "${today}"
        echo "#---------------------------------" >> "${today}"
        echo "# Process pull requests: " >> "${today}"
        echo "##################################" >> "${today}"
    fi

    nvim "+set wrap" -O "${today}" "${yesterday}"
}

# put timestamps in bash history
export HISTTIMEFORMAT='%F %T '
# don't put duplicate commands into the history
export HISTCONTROL=ignoredups
# record only the most recent duplicated command (see above)
export HISTCONTROL=ignoreboth
export HISTIGNORE='pwd:ls:history:'
export HISTSIZE=4096
export EDITOR='nvim'
export VISUAL='nvim'
export AUTOSSH_POLL=30

export MAVEN_OPTS="-Xms512m -Xmx1024m"
export CATALINA_OPTS="-Xms512m -Xmx1024m"
export PAGER=less
export LESS="-iMSx4 -FXR"
export PROMPT_COMMAND=prompt_command
export DISABLE_AUTO_TITLE=true
export GOPATH=~/gocode

#i3
export TERMINAL="qterminal"

# tput acts weird unless TERM holds something terminfo understands
export TERM="xterm"

PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
PATH="${HOME}/cj_bin:${PATH}"
PATH="${HOME}/gocode/bin:${PATH}"
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
PATH="${HOME}/workspace/local-scripts:${PATH}"
PATH="/opt/X11/bin:${PATH}"
PATH="/usr/X11R6/bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
export PATH=${PATH}

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

alias aria2c='aria2c -x 16'
alias flushdns='sudo killall -HUP mDNSResponder'
alias random_file='ls -R | sort -R | tail -1'
alias p.history='eval $(history | cut -c 28- | percol)'
alias p.checkout='git checkout $(git branch | percol | grep -Eo 'ME.*')'
alias p.push='git push -u origin $(git branch | percol | grep -Eo 'ME.*')'
alias p.nvim='nvim $(find ~/Workspace -type f | percol)'
alias git.addnw='git diff -U0 -w --no-color "$@" | git apply --cached --ignore-whitespace --unidiff-zero -'
alias webm2mp4='for FILE in *.webm; do ffmpeg -i "${FILE}" "$(sed "s/.webm//" <<< ${FILE}).mp4" && rm -f "${FILE}"; done'
alias lock='i3lock -c $(openssl rand -hex 3)'
alias pg-start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg-stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

#python3 stuff flips out without these set
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

