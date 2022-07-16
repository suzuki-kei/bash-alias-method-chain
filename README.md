# bash-alias-method-chain

Ruby on Rails (ActiveSupport) における alias_method_chain の Bash 版.

# 使用例

    function hello {
        echo 'Hello'
    }

    function hello_with_trace {
        echo '---- BEGIN ----'
        hello_without_trace "$@"
        echo '---- END ----'
    }

    alias_method_chain hello trace

    $ hello
    ---- BEGIN ----
    Hello
    ---- END ----

