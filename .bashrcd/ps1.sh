function version_control_info {
    B=$(git branch 2>/dev/null | sed -e "/^ /d" -e "s/* \(.*\)/\1/");
    if [ "$B" != "" ]; then
        S="git";
    elif [ -e .bzr ]; then
        S=bzr;
    elif [ -e .hg ]; then
        S="hg";
    elif [ -e .svn ]; then
        S="svn";
    else
        S="";
    fi;
    if [ "$S" != "" ]; then
        if [ "$B" != "" ]; then
            M=$S:$B;
        else
            M=$S;
        fi;
    fi;
    echo $M;
    echo $1;
}

function exit_code_interp {
    CODE=$1;
        case $EXIT_CODE in
            1)
                echo -n "General errors"
            ;;
            2)
                echo -n "Shell misuse"
            ;;
            64)
                echo -n "EX__BASE or EX_USAGE"
            ;;
            65)
                echo -n "EX_DATAERR"
            ;;
            66)
                echo -n "EX_NOINPUT"
            ;;
            67)
                echo -n "EX_NOUSER"
            ;;
            68)
                echo -n "EX_NOHOST"
            ;;
            69)
                echo -n "EX_UNAVAILABLE"
            ;;
            70)
                echo -n "EX_SOFTWARE"
            ;;
            71)
                echo -n "EX_OSERR"
            ;;
            72)
                echo -n "EX_OSFILE"
            ;;
            73)
                echo -n "EX_CANTCREAT"
            ;;
            74)
                echo -n "EX_IOERR"
            ;;
            75)
                echo -n "EX_TEMPFAIL"
            ;;
            76)
                echo -n "EX_PROTOCOL"
            ;;
            77)
                echo -n "EX_NOPERM"
            ;;
            78)
                echo -n "EX_CONFIG"
            ;;
            126)
                echo -n "Cannot execute"
            ;;
            127)
                echo -n "Comamand not found"
            ;;
            128)
                echo -n "Invalid exit code"
            ;;
            129)
                echo -n "SIGHUP"
            ;;
            130)
                echo -n "SIGINT"
            ;;
            131)
                echo -n "SIGQUIT"
            ;;
            132)
                echo -n "SIGILL"
            ;;
            133)
                echo -n "SIGTRAP"
            ;;
            134)
                echo -n "SIGABRT or SIGIOT"
            ;;
            135)
                echo -n "SIGBUS"
            ;;
            136)
                echo -n "SIGFPE"
            ;;
            137)
                echo -n "SIGKILL"
            ;;
            138)
                echo -n "SIGUSR1"
            ;;
            139)
                echo -n "SIGSEGV"
            ;;
            140)
                echo -n "SIGUSR2"
            ;;
            141)
                echo -n "SIGPIPE"
            ;;
            142)
                echo -n "SIGALRM"
            ;;
            143)
                echo -n "SIGTERM"
            ;;
            144)
                echo -n "SIGSTKFLT"
            ;;
            145)
                echo -n "SIGCHLD"
            ;;
            146)
                echo -n "SIGCONT"
            ;;
            147)
                echo -n "SIGSTOP"
            ;;
            148)
                echo -n "SIGTSTP"
            ;;
            149)
                echo -n "SIGTTIN"
            ;;
            150)
                echo -n "SIGTTOU"
            ;;
            151)
                echo -n "SIGURG"
            ;;
            152)
                echo -n "SIGXCPU"
            ;;
            153)
                echo -n "SIGXFSZ"
            ;;
            154)
                echo -n "SIGVTALRM"
            ;;
            155)
                echo -n "SIGPROF"
            ;;
            156)
                echo -n "SIGWINCH"
            ;;
            157)
                echo -n "SIGIO"
            ;;
            158)
                echo -n "SIGPWR"
            ;;
            159)
                echo -n "SIGSYS or SIGUNUSED"
            ;;
            255)
                echo -n "Exit code out of range"
            ;;
        esac
}

function ps1 {
    EXIT_CODE="$1";
    LBRK="$2";
    RBRK="$3";
    USERNAME="$4";
    HOSTNAME="$5";
    PROMPTUSER="$6";
    WORKING_DIRECTORY="$7";
    JOBS="$8";
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
    echo -n -e "${STYLE_DECORATION}[${STYLE_RESET}${STYLE_PRIMARY}${USERNAME}${STYLE_RESET}${STYLE_DECORATION}@${STYLE_RESET}${STYLE_PRIMARY}${HOSTNAME}${STYLE_RESET} ${STYLE_SECONDARY}${WORKING_DIRECTORY}";
    M=$(version_control_info);
    if [ "$M" != "" ]; then
        echo -n -e "${STYLE_INFO}($M)${STYLE_RESET}";
    fi;
    echo -n -e "${STYLE_DECORATION}]${STYLE_RESET}\n";
    if [ $JOBS -ne 0 ]; then
        echo -n -e "${STYLE_DECORATION}{${STYLE_RESET}${STYLE_SECONDARY}${JOBS}${STYLE_RESET}${STYLE_DECORATION}}${STYLE_RESET} ";
    fi;
    echo -n -e "${STYLE_DECORATION}${PROMPTUSER} ${STYLE_RESET}";
}

# prompt variables are substituted before expanded

PS1='`
    EXIT_CODE=$?;
    LBRK="\[";
    RBRK="\]";
    USERNAME="\u";
    HOSTNAME="\H";
    PROMPTUSER="\$";
    WORKING_DIRECTORY="\w";
    JOBS="\j"
    ps1 $EXIT_CODE $LBRK $RBRK $USERNAME $HOSTNAME $PROMPTUSER "$WORKING_DIRECTORY" $JOBS
`';

<< COMMENT
# https://www.gnu.org/software/bash/manual/bash.html#Controlling-the-Prompt
PS1_test=`
echo -e '\\\\\\\\a [\\a] A bell character.';
echo -e '\\\\\\\\d [\\d] The date, in "Weekday Month Date" format (e.g., "Tue May 26").';
echo -e '\\\\\\\\D{format} [\\D{%F}] The format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required. (e.g. %F)'
echo -e '\\\\\\\\e [] An escape character. (not demonstrated)';
echo -e '\\\\\\\\h [\\h] The hostname, up to the first ‘.’.';
echo -e '\\\\\\\\H [\\H] The hostname.';
echo -e '\\\\\\\\j [\\j] The number of jobs currently managed by the shell.';
echo -e '\\\\\\\\l [\\l] The basename of the shell’s terminal device name.';
echo -e '\\\\\\\\n [] A newline. (not demonstrated)';
echo -e '\\\\\\\\r [] A carriage return. (not demonstrated)';
echo -e '\\\\\\\\s [\\s] The name of the shell, the basename of $0 (the portion following the final slash).';
echo -e '\\\\\\\\t [\\t] The time, in 24-hour HH:MM:SS format.';
echo -e '\\\\\\\\T [\\T] The time, in 12-hour HH:MM:SS format.';
echo -e '\\\\\\\\@ [\\@] The time, in 12-hour am/pm format.';
echo -e '\\\\\\\\A [\\A] The time, in 24-hour HH:MM format.';
echo -e '\\\\\\\\u [\\u] The username of the current user.';
echo -e '\\\\\\\\v [\\v] The version of Bash (e.g., 2.00)';
echo -e '\\\\\\\\V [\\V] The release of Bash, version + patchlevel (e.g., 2.00.0)';
echo -e '\\\\\\\\w [\\w] The current working directory, with $HOME abbreviated with a tilde (uses the $PROMPT_DIRTRIM variable).';
echo -e '\\\\\\\\W [\\W] The basename of $PWD, with $HOME abbreviated with a tilde.';
echo -e '\\\\\\\\! [\\!] The history number of this command.';
echo -e '\\\\\\\\# [\\#] The command number of this command.';
echo -e '\\\\\\\\$ [\\$] If the effective uid is 0, #, otherwise $.';
echo -e '\\\\\\\\nnn [] The character whose ASCII code is the octal value nnn. (not demonstrated)';
echo -e '\\\\\\\\\ [\\\\\] A backslash.';
echo -e '\\\\\\\\[ [] Begin a sequence of non-printing characters. This could be used to embed a terminal control sequence into the prompt. (not demonstrated)';
echo -e '\\\\\\\\] [] End a sequence of non-printing characters. (not demonstrated)';
`;
PS1=$PS1_test
COMMENT

unset color_prompt force_color_prompt
