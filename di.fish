function di
    set player "mplayer -cache 512 -cache-min 30 -msgcolor -playlist "

    count $argv | read args
    if test $args = 1
        if test $argv = "channels"
            curl --silent http://www.di.fm \
                | ack 'data-tunein-url="http://www.di.fm/(.*?)"' --output='$1' \
                | sort | uniq | column
        else
            if test $DI_FM_PREMIUM_ID != ""
                set url "$player 'http://listen.di.fm/premium_high/$argv.pls?$DI_FM_PREMIUM_ID'"
            else
                set url "$player 'http://listen.di.fm/public3/$argv.pls'"
            end
            eval $url
        end
    else
        echo
        echo "di channels       list available channels"
        echo "di <channel slug> play a channel"
        echo
    end
end
