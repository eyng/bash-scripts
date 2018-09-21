#!/bin/bash
# ----------------------------------------------------------------
# file: pick.sh
# auth: Ellis Young
# date: 21sep18
# desc: See PrintUsageAndExit() below.
#       Inspired also by: rpen.py.
# ----------------------------------------------------------------

# ----------------------------------------------------------------
# SETTINGS:

RequiredParameters=1
MaximumParameters=7

# ----------------------------------------------------------------
# FUNCTION:

PrintUsageAndExit ()
{
    echo "Desc: colour the given words in the given text (rpen.py substitute)."
    echo "Example call: ls | pick bash git   # lists all files, with bash & git separately coloured."
    echo "Example call: grep 'apple\|pear' | pick apple pear"
    echo "Parameters: 1 to 7 strings"
    echo "Exiting."
    exit 1
}

# ----------------------------------------------------------------
# PRINT HELP IF REQUESTED:

if [ "$1" == "-?" -o "$1" == "-h" -o "$1" == "-help" -o "$1" == "--help" ]
then
  PrintUsageAndExit
fi

# ----------------------------------------------------------------
# PARAMETERS:

if (( ($# < $RequiredParameters) || ($# > $MaximumParameters) ))
then
  PrintUsageAndExit
fi

# ----------------------------------------------------------------
# MAIN:

esc=''   # escape character

command=""
while (( $# > 0 ))
do
    colour="3$#"   # 31 .. 37
    command="$command | sed 's/$1/$esc\[${colour}m$1$esc[0m/g' "
    shift
done

while read line
do
    eval "echo '$line' $command"
done

# ----------------------------------------------------------------
# end of file
# ----------------------------------------------------------------
