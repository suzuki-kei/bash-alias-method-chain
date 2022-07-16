#!/bin/bash
#
# Ruby on Rails (ActiveSupport) における alias_method_chain の Bash 版.
#
# 使用例:
#
#     function hello {
#         echo 'Hello'
#     }
#
#     function hello_with_trace {
#         echo '---- BEGIN ----'
#         hello_without_trace "$@"
#         echo '---- END ----'
#     }
#
#     alias_method_chain hello trace
#
#     $ hello
#     ---- BEGIN ----
#     Hello
#     ---- END ----
#

set -eu
shopt -s expand_aliases

function alias_method_chain
{
    local -r name="$1"
    local -r functionality="$2"

    case $(type -t "$name") in
        alias)
            eval "$(cat <<EOS
                function ${name}_without_${functionality}
                {
                    $(type "$name" | sed -r "s/^$name is aliased to .|.$//g") "\$@"
                }
                alias ${name}='${name}_with_${functionality}'
EOS)"
            return 0
            ;;
        keyword)
            echo "ERROR: $name is shell reserved keyword." >&2
            return 1
            ;;
        function)
            eval "$(cat <<EOS
                function ${name}_without_${functionality}
                {
                    $(type "$name" | tail -n +4 | head -n -1)
                }
                function ${name}
                {
                    ${name}_with_${functionality} "\$@"
                }
EOS)"
            return 0
            ;;
        builtin)
            eval "$(cat <<EOS
                function ${name}_without_${functionality}
                {
                    $name "\$@"
                }
                builtin alias ${name}='${name}_with_${functionality}'
EOS)"
            return 0
            ;;
        file)
            eval "$(cat <<EOS
                function ${name}_without_${functionality}
                {
                    $name "\$@"
                }
                builtin alias ${name}='${name}_with_${functionality}'
EOS)"
            return 0
            ;;
        *)
            echo "ERROR: $(type -t '$name') is unsupported type." >&2
            return 1
            ;;
    esac
}

