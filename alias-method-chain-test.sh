#!/bin/bash

set -eu
shopt -s expand_aliases
source "$(dirname "$0")/alias-method-chain.sh"

function report_assertion_failure {
    local -r line="$1"
    local -r command="$2"

    echo "Assertion failed at line ${line}:"
    echo "$2" | sed -r 's/^/    /'
}
trap 'report_assertion_failure ${LINENO} "${BASH_COMMAND}"' ERR

# ------------------------------------------------------------------------------
#
# alias
#

alias ls='\ls -F'

function ls_with_trace {
    echo '---- BEGIN ----'
    ls_without_trace "$@"
    echo '---- END ----'
}

test "$(type -t ls)" = 'alias'
alias_method_chain ls trace

function ls_with_indent {
    ls_without_indent "$@" | sed -r 's/^/    /'
}

test "$(type -t ls)" = 'alias'
alias_method_chain ls indent

test "$(ls /dev/null)" = "$(cat <<EOS
    ---- BEGIN ----
    /dev/null
    ---- END ----
EOS)"

test "$(ls_without_indent /dev/null)" = "$(cat <<EOS
---- BEGIN ----
/dev/null
---- END ----
EOS)"

test "$(ls_without_trace /dev/null)" = "$(cat <<EOS
/dev/null
EOS)"

# ------------------------------------------------------------------------------
#
# function
#

function greeting {
    echo "$1"
}
function greeting_with_trace
{
    echo '---- BEGIN ----'
    greeting_without_trace "$@"
    echo '---- END ----'
}

test "$(type -t greeting)" = 'function'
alias_method_chain greeting trace

function greeting_with_indent {
    greeting_without_indent "$@" | sed -r 's/^/    /'
}

test "$(type -t greeting)" = 'alias'
alias_method_chain greeting indent

test "$(greeting 'Hello')" = "$(cat <<EOS
    ---- BEGIN ----
    Hello
    ---- END ----
EOS)"

test "$(greeting_without_indent 'Hello')" = "$(cat <<EOS
---- BEGIN ----
Hello
---- END ----
EOS)"

test "$(greeting_without_trace 'Hello')" = "$(cat <<EOS
Hello
EOS)"

# ------------------------------------------------------------------------------
#
# builtin
#

function pwd_with_trace {
    echo '---- BEGIN ----'
    pwd_without_trace "$@"
    echo '---- END ----'
}

test "$(type -t pwd)" = 'builtin'
alias_method_chain pwd trace

function pwd_with_indent {
    pwd_without_indent "$@" | sed -r 's/^/    /'
}

test "$(type -t pwd)" = 'alias'
alias_method_chain pwd indent

test "$(pwd)" = "$(cat <<EOS
    ---- BEGIN ----
    $(builtin pwd)
    ---- END ----
EOS)"

test "$(pwd_without_indent)" = "$(cat <<EOS
---- BEGIN ----
$(builtin pwd)
---- END ----
EOS)"

test "$(pwd_without_trace)" = "$(cat <<EOS
$(builtin pwd)
EOS)"

# ------------------------------------------------------------------------------
#
# file
#

function tr_with_trace {
    echo '---- BEGIN ----'
    tr_without_trace "$@"
    echo '---- END ----'
}

test "$(type -t tr)" = 'file'
alias_method_chain tr trace

function tr_with_indent {
    tr_without_indent "$@" | sed -r 's/^/    /'
}

test "$(type -t tr)" = 'alias'
alias_method_chain tr indent

test "$(echo abcde | tr 'a-z' 'A-Z')" = "$(cat <<EOS
    ---- BEGIN ----
    ABCDE
    ---- END ----
EOS)"

test "$(echo abcde | tr_without_indent 'a-z' 'A-Z')" = "$(cat <<EOS
---- BEGIN ----
ABCDE
---- END ----
EOS)"

test "$(echo abcde | tr_without_trace 'a-z' 'A-Z')" = "$(cat <<EOS
ABCDE
EOS)"

# ------------------------------------------------------------------------------
#
# All test were successful.
#

echo 'OK'

