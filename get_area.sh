#!/bin/bash


exec 3>&1 4>&2 > /dev/null 2>&1


return_json()
{
	exec 1>&3 2>&4

	jq -n \
	    --arg changed "$changed" \
	    --arg rc "$rc" \
	    --arg stdout "$stdout" \
	    --arg stderr "$stderr" \
	    --arg msg "$msg" \
	    '$ARGS.named'

	exec 3>&1 4>&2 > /dev/null 2>&1
}

changed="false"
rc=0
stdout=""
stderr=""
msg=""


source $1


if ! which jq &>/dev/null; then
	exec 1>&3 2>&4
	printf "{ \"changed\": \"$changed\",
		\"rc\": \"1\",
		\"stdout\": \"\",
		\"stderr\": \" This module require 'jq' installed on the target machine.\",
		\"msg\": \"\"}"

	exit 1
fi

if [ "$action" == "triangle" ]; then
	
	if [ -z "$breath" ]; then
        	msg="The value of breath is not provided."
        	rc=1
        	return_json
	fi


	if [ -z "$hight" ]; then
        	msg="The value of hight is not provided."
        	rc=2
        	return_json
	fi

	changed="false"
	bh=$((breath * hight))
	stdout=$(( bh/2))
	msg="Area of triangle"

        return_json
        exit $rc
fi


if [ "$action" == "rectangle" ]; then

        if [ -z "$breath" ]; then
                msg="The value of breath is not provided."
                rc=2
                return_json
        fi


        if [ -z "$breath" ]; then
                msg="The value of breath is not provided."
                rc=2
                return_json
        fi

	changed="false"
	stdout=$((length * breath))
	msg="Area of rectangle"

	return_json
	exit $rc
fi

