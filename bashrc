COLOR_TYPES=(00 01)
COLOR_CODES=(31 32 33 34 35 36)

U1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
U2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
H1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
H2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}
W1=${COLOR_TYPES[$RANDOM % ${#COLOR_TYPES[@]} ]}
W2=${COLOR_CODES[$RANDOM % ${#COLOR_CODES[@]} ]}

export PATH=/opt/local/bin:/opt/local/sbin:/Users/cj/Documents/workspace/starfish-helper-scripts/:$PATH
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_37-b06-434.jdk/Contents/Home
export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=1024m"
export PAGER=less
export LESS="-iMSx4 -FX"
export PS1="\[\e[00;37m\][\[\e[0m\]\[\e[${U1};${U2}m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[${H1};${H2}m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[${W1};${W2}m\]\W\[\e[0m\]\[\e[00;37m\]]\\$ \[\e[0m\]"
if [ -n "$STY" ]; then export PS1="\[\e[00;31m\](screen) \[\e[0m\]$PS1"; fi

alias ls='ls -GFh'
alias grep='grep --color=auto'
alias flushdns='sudo killall -HUP mDNSResponder'

function gibberish () {
    base64 /dev/urandom | head -c $@
}

function renametab () {
        echo -ne "\033]0;"$@"\007"
}
