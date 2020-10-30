#!/bin/bash

usage()
{
    cat <<EOF
usage: $(basename "$0") [-f frame-name] [-o front-name] [-s unit-size]

-h      help
-f      input-name      this is input file name
-o      output-name     this is output file name
-s      unit-size       this is output file size

exp:    $0 -f ./xxx.bin -s 2048 -o xxx_

EOF
    exit 1
}
check_error()
{
    if [ $? -ne 0 ]; then
        echo 
        echo "$1 Failed"
        echo
        exit 1
    fi
}
run_split()
{
    if [ $FILE_PATH != './XXX.bin' -a $FILE_SIZE -ne 0  ]; then
        rm -r down 2>/dev/null
        mkdir down
        split -a 2 -d -b ${FILE_SIZE} ${FILE_PATH} down/${SAVE_NAME}
        for F in down/${SAVE_NAME}* ; do mv $F ${F}.html;done
        chmod ug+x down/*
        echo "split success!"
    else
        echo "param error!"
    fi
    exit 1
}

FILE_PATH='./XXX.bin'
SAVE_NAME='XXX'
FILE_SIZE=0
while getopts ":h:f:s:o:" opt
    do
        case "$opt" in

            f )
                if [ ! -x "$OPTARG" ]; then
                    echo "file is not exist"
                else
                    FILE_PATH="$OPTARG"
                fi
                ;;
            s )
                if [ $OPTARG -gt 2048 ]; then
                    echo "size is exceed limit about 2048 byte"
                else
                    FILE_SIZE="$OPTARG"
                fi
                ;;
            o )
                SAVE_NAME="$OPTARG"
                ;;
            h )
                usage
                ;;
            * ) echo "Unrecongnized option specified"
                usage
                ;;
        esac
    done

run_split


