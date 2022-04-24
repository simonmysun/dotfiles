PS2='`
    LBRK="\[";
    RBRK="\]";
    STYLE_RESET="$LBRK$(tput sgr0)$RBRK"
    STYLE_ALERT="$LBRK$(tput setaf 11; tput setab 9; tput bold)$RBRK";
    STYLE_DECORATION="$LBRK$(tput setaf 36; tput dim)$RBRK";
    STYLE_PRIMARY="$LBRK$(tput setaf 2; tput bold)$RBRK";
    STYLE_SECONDARY="$LBRK$(tput setaf 4; tput bold)$RBRK"
    STYLE_INFO="$LBRK$(tput setaf 11; tput setab 0)$RBRK";
    echo "${STYLE_DECORATION}>${STYLE_RESET} "
`';
