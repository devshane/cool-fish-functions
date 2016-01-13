function wpset
  echo "setting wallpaper on all desktops to $argv"
  /usr/bin/sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value='$argv'"
  killall Dock
end
