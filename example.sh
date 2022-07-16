#!/bin/bash

set -eu
shopt -s expand_aliases
source "$(dirname "$0")/alias-method-chain.sh"

# ------------------------------------------------------------------------------
#
# alias
#

echo '============================================================'
echo

alias ls='\ls -F'

if [[ "$(type -t ls)" != 'alias' ]]; then
    echo 'ERROR: ls is not alias' >&2
fi

function ls_with_trace
{
    echo '---- BEGIN ----'
    ls_without_trace "$@"
    echo '---- END ----'
}
alias_method_chain ls trace

function ls_with_indent
{
    ls_without_indent "$@" | sed -r 's/^/    /'
}
alias_method_chain ls indent

ls /dev/null
echo
ls_without_indent /dev/null
echo
ls_without_trace /dev/null
echo

# ------------------------------------------------------------------------------
#
# function
#

echo '============================================================'
echo

function greeting
{
    echo "$1"
}

if [[ "$(type -t greeting)" != 'function' ]]; then
    echo 'ERROR: greeting is not function' >&2
fi

function greeting_with_trace
{
    echo '---- BEGIN ----'
    greeting_without_trace "$@"
    echo '---- END ----'
}
alias_method_chain greeting trace

function greeting_with_indent
{
    greeting_without_indent "$@" | sed -r 's/^/    /'
}
alias_method_chain greeting indent

greeting 'Hello'
echo
greeting_without_indent 'Hello'
echo
greeting_without_trace 'Hello'
echo

# ------------------------------------------------------------------------------
#
# builtin
#

echo '============================================================'
echo

if [[ "$(type -t pwd)" != 'builtin' ]]; then
    echo 'ERROR: pwd is not alias' >&2
fi

function pwd_with_trace
{
    echo '---- BEGIN ----'
    pwd_without_trace "$@"
    echo '---- END ----'
}
alias_method_chain pwd trace

function pwd_with_indent
{
    pwd_without_indent "$@" | sed -r 's/^/    /'
}
alias_method_chain pwd indent

pwd
echo
pwd_without_indent
echo
pwd_without_trace
echo

# ------------------------------------------------------------------------------
#
# file
#

echo '============================================================'
echo

if [[ "$(type -t tr)" != 'file' ]]; then
    echo 'ERROR: tr is not alias' >&2
fi

function tr_with_trace
{
    echo '---- BEGIN ----'
    tr_without_trace "$@"
    echo '---- END ----'
}
alias_method_chain tr trace

function tr_with_indent
{
    tr_without_indent "$@" | sed -r 's/^/    /'
}
alias_method_chain tr indent

echo abcde | tr 'a-z' 'A-Z'
echo
echo abcde | tr_without_indent 'a-z' 'A-Z'
echo
echo abcde | tr_without_trace 'a-z' 'A-Z'
echo

