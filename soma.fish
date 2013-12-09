function soma
  set player "mplayer -cache 512 -cache-min 30 -msgcolor -playlist"
  set channel_list "/tmp/soma_channel_list"
  set refresh_file ""

  count $argv | read args
  if test $args = 1
    # [potentially] update channel list
    if [ -e "$channel_list" ]
      find $channel_list -mmin +1440 | read refresh_file
    else
      set refresh_file "x"
    end
    if [ "" != $refresh_file ]
      echo "updating channel list"
      curl --silent http://somafm.com/listen/ \
        | ack '/play/(.*?)"' --output='$1' \
        | sort | uniq > $channel_list
    else
      echo "using cached channel list"
    end

    # setup auto-completion
    complete -c soma -e
    cat $channel_list | tr "\\n" " " | read channels
    complete -c soma -a "channels $channels"

    # do something
    if [ $argv = "channels" ]
      cat $channel_list | column
    else
      set cmdline "$player 'http://somafm.com/$argv.pls'"
            
      if [ $SOMA_TITLE_ONLY = 1 ]
        set cmdline "$cmdline 2>&1 | ack \"StreamTitle='(.*?)'\" --output='\$1'"
      end

      eval $cmdline
    end
  else
    echo
    echo "soma channels       list available channels"
    echo "soma <channel slug> play a channel"
    echo
    echo "You can set environment variables to modify behavior:"
    echo
    echo "SOMA_TITLE_ONLY : when set to 1, only display the current song title"
    echo
  end
end
