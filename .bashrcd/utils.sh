alias term='xfce4-terminal'
alias term3='term&term&term'
alias vi="bash -c 'emacsclient -t {%0}'"
alias vim='emacsclient -t -a ""'
alias gvim='emacsclient -c -a ""'
alias emacs='setsid emacsclient -t -a ""'
alias diff='colordiff -W $(( $(tput cols) - 2 ))'
alias bat='bat --color=always --paging=never'
alias thunar='setsid thunar'
alias dolphin='setsid dolphin'
alias ytdl='youtube-dl --all-subs'; # --proxy socks5://127.0.0.1:1080'
#alias 'you-get'='you-get -s 127.0.0.1:1080'
#alias 7zx='7zx_f() { 7z x "-o$1"; };7zx_f;'
sqt="'"
alias killvlc='kill -9 $(killall -v vlc 2>&1 | sed -n "s/^.*(\([0-9]\+\)).*$/\1/p" -)'
alias dedate='node ~/utils/time.js'
alias df='df --exclude-type=tmpfs --exclude-type=devtmpfs --exclude-type=squashfs'

rsync_here() {
    if [ ${#} -ne 1 ]; then
        echo "Usage: rsync_here <target_host>";
        return 64;
    fi
    target_host="${1}";
    target_path="${PWD}";
    echo "${target_path%/}/ >>> ${target_host}:${target_path%/}";
    # source with trailing slash, target without trailing slash
    rsync --archive --itemize-changes --compress-level=9 --partial --progress --info=progress2 --delete-after --fuzzy --checksum "${target_path%/}/" "${target_host}:${target_path%/}";
}

tmux() {
    echo alias called
    if [ ${#} -eq 0 ]; then
        echo try attach
        /usr/bin/tmux a || /usr/bin/tmux
    else
        echo arguments passed
        /usr/bin/tmux ${@}
    fi
}

_please(){
    if [ -z $1 ]; then
        #echo `history | cut -c 8- | tail -n 2 | head -n 1`;
        sudo `history | cut -c 8- | tail -n 2 | head -n 1`;
    else
        #echo $@;
        sudo $@;
    fi;
};
alias please=_please

keepretrying() {
    while true; do
        command && break;
        sleep 5
    done
}

zlipd() (printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" |cat - $@ |gzip -dc)
#https://unix.stackexchange.com/questions/22834/how-to-uncompress-zlib-data-in-unix
flasher () {
    while true; do
        printf "\\e[?5h";
        sleep 0.1;
        printf "\\e[?5l";
        read -s -n1 -t1 && break;
    done;
}
#https://zh.wikipedia.org/w/index.php?oldid=54692737
tgs() {
    para="'msg $1 $(cat $2)'";
    echo $para;
    bash -c "telegram-cli --json -W -e $para";
}

function prettycsv {
    cat $1 | perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' | column -t -s,
}

rndsha1() {
    head -c 999 /dev/urandom | sha1sum
}

history_here() {
    grep "### $PWD$" ~/.bash_history_detailed
}

if [ -d "$HOME/.ssh/hosts.d" ]; then
    complete -W "$(echo `cat ~/.ssh/config ~/.ssh/hosts.d/*.conf | grep "^Host " |awk '{print $2}'`;)" ssh
    complete -W "$(echo `cat ~/.ssh/config ~/.ssh/hosts.d/*.conf | grep "^Host " |awk '{print $2}'`;)" scp
else
    complete -W "$(echo `cat ~/.ssh/config | grep "^Host " |awk '{print $2}'`;)" ssh
    complete -W "$(echo `cat ~/.ssh/config | grep "^Host " |awk '{print $2}'`;)" scp
fi

srcenv() {
    set -o allexport;
    source $1;
    set +o allexport;
}

docker_run() {
    if [ $# -le 1 ]; then
        echo "Usage: docker_run <image> <command>";
        return 64;
    fi
    docker run --rm -it -v "$PWD":/usr/src/myapp -w /usr/src/myapp $@;
}
