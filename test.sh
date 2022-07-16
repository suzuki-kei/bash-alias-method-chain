#!/bin/bash

if $(diff -q <(bash example.sh) expected.txt > /dev/null); then
    echo 'OK'
else
    echo 'NG'
    diff -u <(bash example.sh) expected.txt
fi

