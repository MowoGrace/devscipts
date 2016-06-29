#!/bin/bash

#Developer: Joshua Uzochukwu Luisaac Nwankwo
#Email: joshluisaac@gmail.com
#Compliation of a set of tasks and fuctions that makes exploring a log file easier
#Exploring a log file has never been this easier.

commandName=$1;
LOG_FILE_PATH=$2;
COUNT_LINE_ARGS=$#;
TITLE="Service Engine Log Parser"
RIGHT_NOW=$(date +"-%Y-%m-%d-%H:%M:%S")
#date +"%Y%m%d%H%M%S"
TIME_STAMP="Report generated on $RIGHT_NOW by $USER"
filename=report$RIGHT_NOW.html;

#registry of error flags
error_flags="\
ERROR|\
UNEXPECTED_EXCEPTION|\
An unexpected errror|\
InvalidEventStateException|\
The error occured |\
Check the |\
Cause: |\
Caused by: "

scriptName=$0;
scriptName=$(echo $scriptName | awk -F/ '{print $NF}');
usageCommand="Usage: $scriptName <command> <logfile>";


function _checkCmdArgs_() {
    if [[ $COUNT_LINE_ARGS -ne 2 ]]; then
        echo "Incomplete arguments. Your command line contains only $COUNT_LINE_ARGS arguments";
        echo "$usageCommand";
        if [[ $commandName = "" ]]; then
            echo "Positional parameter 1 is empty";
        fi
        if [[ $LOG_FILE_PATH = "" ]]; then
            echo "Positional parameter 2 is empty";
        fi
        exit 0;
    fi
}

function _showHelp_() {
    echo "$usageCommand";
}

function _showDebugEntries_() {
  echo "Show debug entries";
}

function _showErrorEntries_() {
    egrep "${error_flags}" ${LOG_FILE_PATH}
}

#allow filters so that users can extract queries based on how long it took the query run.
function _showQueryTiming_() {
    echo "Fetch query timing"
}

#send extracted results to a set of email addresses in csv and text format
function _sendEmail_() {
    echo "Send email to email list"
}

#extacts & formats a query string and arguments received by that query string. 
#This function needs the query name you wish to extact
function _extractQueryString_() {
    echo "Extract query string";
}


function _generateChangeLog_() {
    echo "Generate SVN change log";
}



#should be able to generate HTML,PDF,CSV,XML,JSON reports
function _generateErrorReport_() {
    #echo "Generate HMTL document";
    cat <<- _EOF_
    <html>
        <head>
        <title>$TITLE</title>
        </head>
        <body>
        <h1>$TITLE</h1>
        <p>$TIME_STAMP</p>
        <textarea readonly="readonly" cols="140" rows="30" name="logFragment">$(_showErrorEntries_)</textarea>
        </body>
    </html>
_EOF_
}


case "$1" in
    -h | --help)
    _showHelp_;
    ;;
    "showerrors" )
    _checkCmdArgs_;
    _showErrorEntries_;
    ;;
    "generateerrorreport" )
    _checkCmdArgs_;
    _generateErrorReport_ > $filename;
    ;;
    *)
    _showHelp_;
    ;;
esac
