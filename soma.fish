function soma
    set player "mplayer -cache 512 -cache-min 30 -msgcolor -playlist "

    count $argv | read args
    if test $args = 1
        set url "$player 'http://somafm.com/$argv.pls'"
        eval $url
    else
        echo
        echo "soma <channel slug>: play a channel"
        echo
    end
end
