function soma
  set player "mplayer -cache 512 -cache-min 30 -msgcolor -playlist "

  count $argv | read args
  if test $args = 1
    if test $argv = "stations"
      echo "nope!"
    else
      set cmdline "$player 'http://somafm.com/$argv.pls'"
            
      if [ $SOMA_HIDE_STDERR = 1 ]
        set cmdline "$cmdline 2>&1"
      end

      if [ $SOMA_TITLE_ONLY = 1 ]
        set cmdline "$cmdline | ack \"StreamTitle='(.*?)'\" --output='\$1'"
      end

      eval $cmdline
    end
  else
    echo
    echo "soma <channel slug>: play a channel"
    echo
    echo "You can set environment variables to modify behavior:"
    echo
    echo "SOMA_HIDE_STDERR: when set to 1, redirects stderr to /dev/null"
    echo "SOMA_TITLE_ONLY : when set to 1, only display the current song title"
    echo
  end
end
