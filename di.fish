function di
  set hide_stderr 0       # if 1, hide all stderr output
  set title_only 0        # if 1, only show song titles
  set player "mplayer -cache 512 -cache-min 30 -msgcolor -playlist "
  set channel_list "/tmp/di_channel_list"
  set refresh_file ""

  count $argv | read args
  if [ $args = 1 ]

    # [potentially] update channel list
    if [ -e "$channel_list" ]
      find $channel_list -mmin +1440 | read refresh_file
    else
      set refresh_file "x"
    end
    if [ "" != $refresh_file ]
      echo "updating channel list"
      curl --silent http://www.di.fm \
        | ack 'data-tunein-url="http://www.di.fm/(.*?)"' --output='$1' \
        | sort | uniq > $channel_list
    else
      echo "using cached channel list"
    end

    # setup auto-completion
    complete -c di -e
    cat $channel_list | tr "\\n" " " | read channels
    complete -c di -a "channels $channels"

    # do something
    if [ $argv = "channels" ]
      cat $channel_list | column
    else
      if [ $DI_FM_PREMIUM_ID != "" ]
        set cmdline "$player 'http://listen.di.fm/premium_high/$argv.pls?$DI_FM_PREMIUM_ID'"
      else
        set cmdline "$player 'http://listen.di.fm/public3/$argv.pls'"
      end
            
      if [ $hide_stderr = 1 ]
        set cmdline "$cmdline 2>&1"
      end

      if [ $title_only = 1 ]
        set cmdline "$cmdline | ack \"StreamTitle='(.*?)'\" --output='\$1'"
      end

      eval $cmdline
    end
  else
    echo
    echo "di channels       list available channels"
    echo "di <channel slug> play a channel"
    echo
  end
end
