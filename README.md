# bash-alias-method-chain

Ruby on Rails (ActiveSupport) における alias_method_chain の Bash 版.

# 使用例

    source alias-method-chain.sh

    # スクリプト中で alias を使用する場合に必要.
    shopt -s expand_aliases

    function hello {
        echo "Hello $1"
    }

    function hello_with_trace {
        echo '---- BEGIN ----'
        hello_without_trace "$@"
        echo '---- END ----'
    }

    # alias_method_chain は以下を行う:
    #
    #     * hello と同じ内容の hello_without_trace を定義する.
    #     * 次に, 元の hello を hello_with_trace で置き換える.
    #
    alias_method_chain hello trace

    # hello を呼び出すと hello_with_trace が実行され, 以下の出力となる:
    #
    #     ---- BEGIN ----
    #     Hello Taro
    #     ---- END ----
    #
    hello 'Taro'

# 各種手順

    # テストを実行する
    $ bash alias-method-chain-test.sh

