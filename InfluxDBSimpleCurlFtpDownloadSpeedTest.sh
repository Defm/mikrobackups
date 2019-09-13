#!/usr/bin/env bash
 
# -- ABOUT THIS PROGRAM: ------------------------------------------------------
#
# Author:       Defm
# Version:      1.0.0
# Description:  simple Curl download speed test
# Source:       https://github.com/Defm/mikrobackups/blob/master/InfluxDBSimpleCurlFtpDownloadSpeedTest.sh
#
# -- INSTRUCTIONS: ------------------------------------------------------------
#
# Execute:
#   $ chmod u+x InfluxDBSimpleCurlFtpDownloadSpeedTest.sh && ./InfluxDBSimpleCurlFtpDownloadSpeedTest.sh
#
# Options:
#   -h|--help                   Displays this help
#   -v|--verbose                Displays verbose output
#   -nc|--no-colour             Disables colour output
#   -cr|--cron                  Run silently unless we encounter an error
#
# Alias:
#   alias myalias="bash ~/path/to/script/InfluxDBSimpleCurlFtpDownloadSpeedTest.sh"
#
# Example:
#   some example goes here
#
# Important:
#   some important note goes here
#
# -- CHANGELOG: ---------------------------------------------------------------
#
#   PROGRAM:        InfluxDBSimpleCurlFtpDownloadSpeedTest.sh
#   DESCRIPTION:    First release
#   VERSION:        1.0.0
#   DATE:           xx/xx/xxxx
#   AUTHOR:         Defm (defm.kopcap@gmail.com)
#
# -- TODO & FIXES: ------------------------------------------------------------
#
#   - some FIX or TODO here
#
# -----------------------------------------------------------------------------

# A better class of script...
set -o errexit          # Exit on most errors (when any command fails)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)
set -o history          # enable !! command completion
set -o histexpand
set -o verbose


# DESC: Handler for unexpected errors
# ARGS: $1 (optional): Exit code (defaults to 1)
# OUTS: None
function script_trap_err() {
    local exit_code=1
    local history_last_command=$(!!)

    # Disable the error trap handler to prevent potential recursion
    trap - ERR

    # Consider any further errors non-fatal to ensure we run to completion
    set +o errexit
    set +o pipefail

    # Validate any provided exit code
    if [[ ${1-} =~ ^[0-9]+$ ]]; then
        exit_code="$1"
    fi

    # Output debug data if in Cron mode
    # Restore original file output descriptors
    if [[ -n ${script_output-} ]]; then
        exec 1>&3 2>&4
    fi

    # Print basic debugging information
    printf '%b\n' "$ta_none"
    printf '***** Abnormal termination of script *****\n'
    printf 'Script Path:            %s\n' "$script_path"
    printf 'Script Parameters:      %s\n' "$script_params"
    printf 'Script Exit Code:       %s\n' "$exit_code"
    printf 'Script Last Command:    %s\n' "$last_command"

    # Print the script log if we have it. It's possible we may not if we
    # failed before we even called cron_init(). This can happen if bad
    # parameters were passed to the script so we bailed out very early.
    if [[ -n ${script_output-} ]]; then
        printf 'Script Output:\n\n%s' "$(cat "$script_output")"
    else
        printf 'Script Output:          None (failed before log init)\n'
    fi

    # Exit with failure status
    exit "$exit_code"
}


# DESC: Handler for exiting the script
# ARGS: None
# OUTS: None
function script_trap_exit() {
 
    cd "$orig_cwd"

    # Remove Cron mode script log
    if [[ -n ${cron-} && -f ${script_output-} ]]; then
        rm "$script_output"
    fi

    # Remove script execution lock
    if [[ -d ${script_lock-} ]]; then
        rmdir "$script_lock"
    fi

    # Restore terminal colours
    printf '%b' "$ta_none"
}

# DESC: Handler for debug (this will run before any command is executed.) the script
# ARGS: None
# OUTS: None
function trap_preCommand() {
    
    # keep track of the last executed command
    # just set variables to be accessible

    last_command=$current_command;
    current_command=$BASH_COMMAND;

    echo @VARIABLE-TRACE> "$(basename ${BASH_SOURCE[0]})" "${LINENO[0]}" "${BASH_COMMAND}"

    if [ -z "$AT_PROMPT" ]; then
        return
    fi
    unset AT_PROMPT

    echo "Running PreCommand"
}

# DESC: This will run after the execution of the previous full command line
# ARGS: None
# OUTS: None
FIRST_PROMPT=1
function trap_PostCommand() {
  AT_PROMPT=1

  if [ -n "$FIRST_PROMPT" ]; then
    unset FIRST_PROMPT
    return
  fi

  # Do stuff.
  echo "Running PostCommand"
}
PROMPT_COMMAND="PostCommand"


# DESC: Exit script with the given message
# ARGS: $1 (required): Message to print on exit
#       $2 (optional): Exit code (defaults to 0)
# OUTS: None
function script_exit() {
    if [[ $# -eq 1 ]]; then
        printf '%s\n' "$1"
        exit 0
    fi

    if [[ ${2-} =~ ^[0-9]+$ ]]; then
        printf '%b\n' "$1"
        # If we've been provided a non-zero exit code run the error trap
        if [[ $2 -ne 0 ]]; then
            script_trap_err "$2"
        else
            exit 0
        fi
    fi

    script_exit 'Missing required argument to script_exit()!' 2
}


# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $orig_cwd: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script
#       $script_params: The original parameters provided to the script
#       $ta_none: The ANSI control code to reset all text attributes
# NOTE: $script_path only contains the path that was used to call the script
#       and will not resolve any symlinks which may be present in the path.
#       You can use a tool like realpath to obtain the "true" path. The same
#       caveat applies to both the $script_dir and $script_name variables.
function script_init() {
    # Useful paths
    readonly orig_cwd="$PWD"
    readonly script_path="${BASH_SOURCE[0]}"
    readonly script_dir="$(dirname "$script_path")"
    readonly script_name="$(basename "$script_path")"
    readonly script_params="$*"

    # Important to always set as we use it in the exit handler
    readonly ta_none="$(tput sgr0 2> /dev/null || true)"
}


# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-colour was set the variables will be empty
function colour_init() {
    if [[ -z ${no_colour-} ]]; then
        # Text attributes
        readonly ta_bold="$(tput bold 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly ta_uscore="$(tput smul 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly ta_blink="$(tput blink 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly ta_reverse="$(tput rev 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly ta_conceal="$(tput invis 2> /dev/null || true)"
        printf '%b' "$ta_none"

        # Foreground codes
        readonly fg_black="$(tput setaf 0 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_blue="$(tput setaf 4 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_cyan="$(tput setaf 6 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_green="$(tput setaf 2 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_magenta="$(tput setaf 5 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_red="$(tput setaf 1 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_white="$(tput setaf 7 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly fg_yellow="$(tput setaf 3 2> /dev/null || true)"
        printf '%b' "$ta_none"

        # Background codes
        readonly bg_black="$(tput setab 0 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_blue="$(tput setab 4 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_cyan="$(tput setab 6 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_green="$(tput setab 2 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_magenta="$(tput setab 5 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_red="$(tput setab 1 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_white="$(tput setab 7 2> /dev/null || true)"
        printf '%b' "$ta_none"
        readonly bg_yellow="$(tput setab 3 2> /dev/null || true)"
        printf '%b' "$ta_none"
    else
        # Text attributes
        readonly ta_bold=''
        readonly ta_uscore=''
        readonly ta_blink=''
        readonly ta_reverse=''
        readonly ta_conceal=''

        # Foreground codes
        readonly fg_black=''
        readonly fg_blue=''
        readonly fg_cyan=''
        readonly fg_green=''
        readonly fg_magenta=''
        readonly fg_red=''
        readonly fg_white=''
        readonly fg_yellow=''

        # Background codes
        readonly bg_black=''
        readonly bg_blue=''
        readonly bg_cyan=''
        readonly bg_green=''
        readonly bg_magenta=''
        readonly bg_red=''
        readonly bg_white=''
        readonly bg_yellow=''
    fi
}


# DESC: Initialise Cron mode
# ARGS: None
# OUTS: $script_output: Path to the file stdout & stderr was redirected to
function cron_init() {
    if [[ -n ${cron-} ]]; then
        # Redirect all output to a temporary file
        readonly script_output="$(mktemp --tmpdir "$script_name".XXXXX)"
        exec 3>&1 4>&2 1>"$script_output" 2>&1
    fi
}


# DESC: Acquire script lock
# ARGS: $1 (optional): Scope of script execution lock (system or user)
# OUTS: $script_lock: Path to the directory indicating we have the script lock
# NOTE: This lock implementation is extremely simple but should be reliable
#       across all platforms. It does *not* support locking a script with
#       symlinks or multiple hardlinks as there's no portable way of doing so.
#       If the lock was acquired it's automatically released on script exit.
function lock_init() {
    local lock_dir
    if [[ $1 = 'system' ]]; then
        lock_dir="/tmp/$script_name.lock"
    elif [[ $1 = 'user' ]]; then
        lock_dir="/tmp/$script_name.$UID.lock"
    else
        script_exit 'Missing or invalid argument to lock_init()!' 2
    fi

    if mkdir "$lock_dir" 2> /dev/null; then
        readonly script_lock="$lock_dir"
        verbose_print "Acquired script lock: $script_lock"
    else
        script_exit "Unable to acquire script lock: $lock_dir" 2
    fi
}


# DESC: Pretty print the provided string
# ARGS: $1 (required): Message to print (defaults to a green foreground)
#       $2 (optional): Colour to print the message with. This can be an ANSI
#                      escape code or one of the prepopulated colour variables.
#       $3 (optional): Set to any value to not append a new line to the message
# OUTS: None
function pretty_print() {
    if [[ $# -lt 1 ]]; then
        script_exit 'Missing required argument to pretty_print()!' 2
    fi

    if [[ -z ${no_colour-} ]]; then
        if [[ -n ${2-} ]]; then
            printf '%b' "$2"
        else
            printf '%b' "$fg_green"
        fi
    fi

    # Print message & reset text attributes
    if [[ -n ${3-} ]]; then
        printf '%s%b' "$1" "$ta_none"
    else
        printf '%s%b\n' "$1" "$ta_none"
    fi
}


# DESC: Only pretty_print() the provided string if verbose mode is enabled
# ARGS: $@ (required): Passed through to pretty_print() function
# OUTS: None
function verbose_print() {
    if [[ -n ${verbose-} ]]; then
        pretty_print "$@"
    fi
}


# DESC: Combines two path variables and removes any duplicates
# ARGS: $1 (required): Path(s) to join with the second argument
#       $2 (optional): Path(s) to join with the first argument
# OUTS: $build_path: The constructed path
# NOTE: Heavily inspired by: https://unix.stackexchange.com/a/40973
function build_path() {
    if [[ $# -lt 1 ]]; then
        script_exit 'Missing required argument to build_path()!' 2
    fi

    local new_path path_entry temp_path

    temp_path="$1:"
    if [[ -n ${2-} ]]; then
        temp_path="$temp_path$2:"
    fi

    new_path=
    while [[ -n $temp_path ]]; do
        path_entry="${temp_path%%:*}"
        case "$new_path:" in
            *:"$path_entry":*) ;;
                            *) new_path="$new_path:$path_entry"
                               ;;
        esac
        temp_path="${temp_path#*:}"
    done

    # shellcheck disable=SC2034
    build_path="${new_path#:}"
}


# DESC: Check a binary exists in the search path
# ARGS: $1 (required): Name of the binary to test for existence
#       $2 (optional): Set to any value to treat failure as a fatal error
# OUTS: None
function check_binary() {
    if [[ $# -lt 1 ]]; then
        script_exit 'Missing required argument to check_binary()!' 2
    fi

    if ! command -v "$1" > /dev/null 2>&1; then
        if [[ -n ${2-} ]]; then
            script_exit "Missing dependency: Couldn't locate $1." 1
        else
            verbose_print "Missing dependency: $1" "${fg_red-}"
            return 1
        fi
    fi

    verbose_print "Found dependency: $1"
    return 0
}


# DESC: Validate we have superuser access as root (via sudo if requested)
# ARGS: $1 (optional): Set to any value to not attempt root access via sudo
# OUTS: None
function check_superuser() {
    local superuser test_euid
    if [[ $EUID -eq 0 ]]; then
        superuser=true
    elif [[ -z ${1-} ]]; then
        if check_binary sudo; then
            pretty_print 'Sudo: Updating cached credentials ...'
            if ! sudo -v; then
                verbose_print "Sudo: Couldn't acquire credentials ..." \
                              "${fg_red-}"
            else
                test_euid="$(sudo -H -- "$BASH" -c 'printf "%s" "$EUID"')"
                if [[ $test_euid -eq 0 ]]; then
                    superuser=true
                fi
            fi
        fi
    fi

    if [[ -z ${superuser-} ]]; then
        verbose_print 'Unable to acquire superuser credentials.' "${fg_red-}"
        return 1
    fi

    verbose_print 'Successfully acquired superuser credentials.'
    return 0
}


# DESC: Run the requested command as root (via sudo if requested)
# ARGS: $1 (optional): Set to zero to not attempt execution via sudo
#       $@ (required): Passed through for execution as root user
# OUTS: None
function run_as_root() {
    if [[ $# -eq 0 ]]; then
        script_exit 'Missing required argument to run_as_root()!' 2
    fi

    local try_sudo
    if [[ ${1-} =~ ^0$ ]]; then
        try_sudo=true
        shift
    fi

    if [[ $EUID -eq 0 ]]; then
        "$@"
    elif [[ -z ${try_sudo-} ]]; then
        sudo -H -- "$@"
    else
        script_exit "Unable to run requested command as root: $*" 1
    fi
}


# DESC: Usage help
# ARGS: None
# OUTS: None
function script_usage() {
    cat << EOF
Usage:
    -h|--help                  Displays this help
    -v|--verbose               Displays verbose output
    -nc|--no-colour             Disables colour output
    -cr|--cron                  Run silently unless we encounter an error
EOF
}


# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h|--help)
                script_usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                ;;
            -nc|--no-colour)
                no_colour=true
                ;;
            -cr|--cron)
                cron=true
                ;;
            *)
                script_exit "Invalid parameter was provided: $param" 2
                ;;
        esac
    done
}


# CUSTOM CODE SECTION

fileName="50MB.zip";


# DESC: This is the main routine of our bash program
# ARGS: $1 (required): Testing protocol, ftp or http
#       $2 (required): File name to be downloaded (puts to /dev/null)
#       $3 (required): Varible name the result to be put into
# OUTS: float, download speed int kbps
function speedTest() {

    if [[ $# -lt 3 ]]; then
        script_exit 'Missing required argument to speedTest()!' 2
    fi

	local reqMode="$1";
	local filName="$2";
    local replyVarName=$3;
    
    verbose_print "Getting $filName ($reqMode) download speed" $ $bg_white

    set +e
    curlResult=$(curl --silent --show-error --fail --connect-timeout 8 ${reqMode}://speedtest.tele2.net/${filName} --write-out "%{speed_download}" --output /dev/null | sed "s/\,/\./g" | tr -d '\n');
    set -e

    curlExitCode=$?;

    if test "$curlExitCode" -eq "0"; then
        eval $replyVarName="'$curlResult'" #construct result variable and assign it's value
        verbose_print "Got $filName ($reqMode) download speed $curlResult kbps" $bg_white
        return 0;
    else
        verbose_print "the curl command failed with: $curlExitCode" $bg_white
        return 190;
    fi
    
}

# DESC: writes stats to Influx DB via HTTP API
# ARGS: $1 (required): Testing protocol, ftp or http
#       $2 (required): File name to be downloaded, in most common cases it just keeps it's size, ex. 3MB.zip, 500KB.zip, 1GB.zip
#       $3 (required): Gateway, you're testing, for me it always VPN
#       $3 (required): speed rate in kbps
# OUTS:
function writeStats() {

    if [[ $# -lt 4 ]]; then
        script_exit 'Missing required argument to writeStats()!' 2
    fi

	local reqMode="$1";
	local filName="$2";
    local GW="$3";
    local dlSpeed="$4";

    verbose_print "Sending $filName ($reqMode) speed stats to InfluxDB" $bg_white
    
	curl --user bash:bash --request POST --url 'http://influxdb/write?db=bashscripts' --data "SpeedStats,FileSize=$filName,mode=$reqMode,Gateway=$GW dlspeed=$dlSpeed"

    verbose_print "Sent $filName ($reqMode) download speed $dlSpeed kbps to InfluxDB" $bg_white

    return 0;
}

# DESC: main infinite loop
# ARGS: $@
# OUTS:
function mainLoop() {

    local protocols=( [1]=ftp [2]=http )
    local sizes=( [1]=3MB.zip [2]=10MB.zip [3]=512KB.zip)

    for proto in ${protocols[*]}
    do
 
        for size in ${sizes[*]}
        do

            pretty_print "Speedtest $proto of $size"

            speedTest "$proto" "$size" "REPLY" 

            writeStats "$proto" "$size" "VPN" $REPLY

            pretty_print "Done speedtest $proto of $size"

        done

    done
 
    pretty_print "Waiting for next run (17min)..." $fg_yellow
    pretty_print "Press CTRL+C to stop the script execution" $fg_yellow

    sleep 17m;

    #recursion, infinite loop
    mainLoop "$@" 

    return 0;
}

#

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {
    trap script_trap_err ERR
    trap script_trap_exit EXIT
  
    if [[ -n ${verbose-} ]]; then
        trap trap_preCommand DEBUG
    fi
 
    script_init "$@"
    parse_params "$@"
    cron_init
    colour_init

    check_binary "curl" "-1"
    check_binary "bc" "-1"

    mainLoop "$@" 

 }

# Make it rain
main "$@"


