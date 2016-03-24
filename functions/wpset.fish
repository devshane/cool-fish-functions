function wpset
  command echo $argv | grep "/" | read slasher
  if test "$slasher" = ""
    set path "~/Dropbox/Pictures/Wallpaper/$argv"
  else
    set path $argv
  end
  echo "setting wallpaper on all desktops to $path"
  /usr/bin/sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value='$path'"
  killall Dock
end
