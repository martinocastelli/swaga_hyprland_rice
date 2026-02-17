#!/bin/bash

dropbox-cli running

RETVAL=$?

if  [ $RETVAL -eq 1 ]; then
	echo '{"text": ""}'
else 
	echo '{"text": ""}'
fi

