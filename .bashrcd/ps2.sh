function ps1 {
    STYLE_RESET="$LBRK$(tput sgr0)$RBRK"
    STYLE_ALERT="$LBRK$(tput setaf 11; tput setab 9; tput bold)$RBRK";
    STYLE_DECORATION="$LBRK$(tput setaf 36; tput dim)$RBRK";
    STYLE_PRIMARY="$LBRK$(tput setaf 2; tput bold)$RBRK";
    STYLE_SECONDARY="$LBRK$(tput setaf 4; tput bold)$RBRK"
    STYLE_INFO="$LBRK$(tput setaf 11; tput setab 0)$RBRK";
    if [ $EXIT_CODE -ne 0 ]; then
        echo -n -e "${STYLE_ALERT}${EXIT_CODE}${STYLE_RESET}${STYLE_INFO}";
        echo -n -e $(exit_code_interp $EXIT_CODE)
        echo -n -e "${STYLE_RESET}"
    fi;
    echo -n -e "${STYLE_DECORATION}[${STYLE_RESET}${STYLE_PRIMARY}${USERNAME}@${HOSTNAME}${STYLE_RESET} ${STYLE_SECONDARY}${WORKING_DIRECTORY}";
    M=$(version_control_info);
    if [ "$M" != "" ]; then
        echo -n -e "${STYLE_INFO}($M)${STYLE_RESET}";
    fi;
    echo -n -e "${STYLE_DECORATION}]${STYLE_RESET}\n${STYLE_DECORATION}";
    if [ $JOBS -ne 0 ]; then
        echo -n -e "${STYLE_DECORATION}[${STYLE_RESET}${STYLE_SECONDARY}${JOBS}${STYLE_RESET}${STYLE_DECORATION}]${STYLE_RESET} ";
    fi;
    echo -n -e "${PROMPTUSER} ${STYLE_RESET}";
}

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
