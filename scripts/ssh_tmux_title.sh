#!/bin/bash
# screen_ssh.sh by Chris Jones
# Modified by Ninad Pundalik
# Released under the GNU GPL v2 licence.
# Set the title of the current screen to the username and hostname being ssh'd to
#
# usage: screen_ssh.sh $PPID hostname username
#
# This is intended to be called by ssh(1) as a LocalCommand.
# For example, put this in ~/.ssh/config:
#
# Host *
# LocalCommand /path/to/screen_ssh.sh $PPID %h %r

# If it's not working and you want to know why, set DEBUG to 1 and check the
# logfile.
DEBUG=1
DEBUGLOG="$HOME/.ssh/screen_ssh.log"

set -e
set -u

dbg ()
{
if [ "$DEBUG" -gt 0 ]; then
echo "$(date) :: $*" >> $DEBUGLOG
fi
}

dbg "$0 $*"

# We only care if we are in a terminal
tty -s

# We also only care if we are in screen, which we infer by $TERM starting
# with "screen"
REGEX="^screen"
if ! [[ "${TERM}" =~ ^"screen" ]]; then
	echo "not a term"
dbg "Not a screen session, ${TERM:0:5} != 'screen'"
exit
fi

# We must be given three arguments - our parent process, a hostname
# (which may be "%n" if we are being called by an older SSH) and a username
if [ $# != "3" ]; then
dbg "Not given enough arguments (must have PPID, hostname and username)"
exit
fi

# Use the safer %h and %r variables. %n has a buggy implementation in some versions of OpenSSH
HOST="$2"
USER="$3"

echo $HOST | awk '{ printf ("\033k%s\033\\", $NF) }'

dbg "Done."
