export PATH="/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PAGER=less
export LESS="-iMSx4 -FX"
export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=1024m"

alias ls='ls -GFh'
alias grep='grep --color=auto'
alias flushdns='sudo killall -HUP mDNSResponder'

function gibberish () {
    base64 /dev/urandom | head -c $@
}

function renametab () {
    echo -ne "\033]0;"$@"\007"
}
