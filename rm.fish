function rm
  for param in $argv
    command echo "$param" | cut -b1 | read is_arg
    if [ "$is_arg" != "-" ]
        set destination ""
        # strip trailing /
        command echo "$param" | sed 's/\/$//g' | read f
        # if it exists in .Trash, give it some uniqueness
        if [ -e "$HOME/.Trash/$f" ]
            command date +"%m%d%Y%H%M%S" | read d
            random | read rnd
            set destination "/$f-$d-$rnd"
        end
    
        echo "Moving '$f' to '$HOME/.Trash$destination'"
        /bin/mv "$f" "$HOME/.Trash$destination"
    end
  end
end
