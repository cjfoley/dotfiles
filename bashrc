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
    [ "$TERM" == "screen" ] && PS1+="\[\e[${S1};${S2}m\]★  \[\e[0m\]"

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

    if [ "$TERM" == "screen" ]; then
        screen -X title "${NAME}"
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

export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=1024m"
export PAGER=less
export LESS="-iMSx4 -FX"
export PROMPT_COMMAND=prompt_command
export DISABLE_AUTO_TITLE=true
export GOPATH=~/gocode

PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/gocode/bin:${PATH}"
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export PATH=${PATH}

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

alias ls='ls -GFh'
alias grep='grep --color=auto'
alias flushdns='sudo killall -HUP mDNSResponder'
alias worklog='vim "+set wrap" -O "$HOME/Dropbox/Work/worklog/$(date +"%Y%m%d").txt" $(find $HOME/Dropbox/Work/worklog -type f -name *.txt ! -name "$(date +"%Y%m%d").txt" | sort | tail -1)'
alias worklog_search='find $HOME/Dropbox/Work/worklog -type f -name *.txt | percol'

#work ssh organization
#ORE
alias ore_web1_ea='rename web1-ea.ore && ssh web1-ea.ore.starfishsolutions.com'
alias ore_web2_ea='rename web2-ea.ore && ssh web2-ea.ore.starfishsolutions.com'
alias ore_ea='rename db1.ore && ssh -f -N db1.ore && psql -h localhost -p 10000 -U starfish -d ea_ore'
alias ore_sfadmin_ea='rename sfadmin-db1.ore && ssh -f -N sfadmin-db1.ore && psql -h localhost -p 10001 -U starfish -d sfadmin_ea_ore'
alias ore_ccsf_test='rename ccsf-test.db && ssh -f -N ccsf-test.db && psql -h localhost -p 10003 -U starfish -d ccsf_test'
alias ore_4cd_test='rename 4cd-test.db && ssh -f -N 4cd-test.db && psql -h localhost -p 10004 -U starfish -d 4cd_test'
alias ore_scccd_test='rename scccd-test.db && ssh -f -N scccd-test.db && psql -h localhost -p 10005 -U starfish -d scccd_test'
alias ore_elcamino_test='rename elcamino-test.db && ssh -f -N elcamino-test.db && psql -h localhost -p 10006 -U starfish -d elcamino_test'
alias ore_vvc_test='rename vvc-test.db && ssh -f -N vvc-test.db && psql -h localhost -p 10007 -U starfish -d vvc_test'
alias ore_santarosa_test='rename santarosa-test.db && ssh -f -N santarosa-test.db && psql -h localhost -p 10008 -U starfish -d santarosa_test'
alias ore_sbccd_test='rename sbccd-test.db && ssh -f -N sbccd-test.db && psql -h localhost -p 10009 -U starfish -d sbccd_test'
alias ore_ea_ash='rename ea-ash.db && ssh -f -N ea-ash.db && psql -h localhost -p 10010 -U starfish -d ea_ash'
alias ore_ops='rename db2.ore && ssh -f -N db2.ore && psql -h localhost -p 10011 -U starfish -d ea_ore'
alias ore_sfadmin_ops='rename sfadmin-db2.ore && ssh -f -N sfadmin-db2.ore && psql -h localhost -p 10012 -U starfish -d sfadmin_ops_ore'

#SJC
alias sjc_web3='rename web3.sjc && ssh web3.sjc.starfishsolutions.com'
alias sjc_web4='rename web4.sjc && ssh web4.sjc.starfishsolutions.com'
alias sjc_web5='rename web5.sjc && ssh web5.sjc.starfishsolutions.com'
alias sjc_web6='rename web6.sjc && ssh web6.sjc.starfishsolutions.com'
alias sjc_db4='rename db4.sjc && ssh db4.sjc.starfishsolutions.com'
alias sjc_db5='rename db5.sjc && ssh db5.sjc.starfishsolutions.com'
alias sjc_db6='rename db6.sjc && ssh db6.sjc.starfishsolutions.com'
alias sjc_db7='rename db7.sjc && ssh db7.sjc.starfishsolutions.com'
alias sjc_db8='rename db8.sjc && ssh db8.sjc.starfishsolutions.com'
alias sjc_db9='rename db9.sjc && ssh db9.sjc.starfishsolutions.com'
alias sjc_db10='rename db10.sjc && ssh db10.sjc.starfishsolutions.com'
alias sjc_db11='rename db11.sjc && ssh db11.sjc.starfishsolutions.com'

#ASH
alias ash_web1='rename web1.ash && ssh web1.ash.starfishsolutions.com'
alias ash_web2='rename web2.ash && ssh web2.ash.starfishsolutions.com'
alias ash_web3='rename web3.ash && ssh web3.ash.starfishsolutions.com'
alias ash_web4='rename web4.ash && ssh web4.ash.starfishsolutions.com'
alias ash_db2='rename db2.ash && ssh db2.ash.starfishsolutions.com'
alias ash_db3='rename db3.ash && ssh db3.ash.starfishsolutions.com'
alias ash_db4='rename db4.ash && ssh db4.ash.starfishsolutions.com'
alias ash_db5='rename db5.ash && ssh db5.ash.starfishsolutions.com'
alias ash_db6='rename db6.ash && ssh db6.ash.starfishsolutions.com'
alias ash_db7='rename db7.ash && ssh db7.ash.starfishsolutions.com'
alias ash_db8='rename db8.ash && ssh db8.ash.starfishsolutions.com'

#IRL
alias irl_web1='rename web1.irl && ssh web1.irl.external.starfishsolutions.com'
alias irl_web2='rename web2.irl && ssh web2.irl.external.starfishsolutions.com'
alias irl_db1='rename db1.irl && ssh -f -N db1.irl && psql -h localhost -p 12000 -U starfish -d ea_irl'
alias irl_db2='rename db2.irl && ssh -f -N db2.irl && psql -h localhost -p 12001 -U starfish -d ops_irl'

#staging
alias stage='rename stage && ssh stage.starfishsolutions.com'
alias stage_rc='rename stage-rc && ssh stage-rc.starfishsolutions.com'
alias stage_ea='rename stage-ea && ssh stage-ea.starfishsolutions.com'
alias stage_ops='rename stage-ops && ssh stage-ops.starfishsolutions.com'
alias stage_db='rename stage db && ssh -f -N stage.db && psql -h localhost -p 9000 -U starfish -d stage'
alias stage_rc_db='rename stage-rc db && ssh -f -N stage-rc.db && psql -h localhost -p 9001 -U starfish -d stage_rc'
alias stage_ea_db='rename stage-ea db && ssh -f -N stage-ea.db && psql -h localhost -p 9002 -U starfish -d stage_ea'
alias stage_ops_db='rename stage-ops db && ssh -f -N stage-ops.db && psql -h localhost -p 9003 -U starfish -d stage_ops'

