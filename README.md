# Cool Fish Functions

Cool fish functions.

### di.fish

Requires: curl, mplayer, and ack. You can install them with brew.

Starts mplayer for DI.fm channels. `di channels` lists the channels, `di <channel>` starts playing one. You
can set environment variables to modify behavior:

```
DI_FM_PREMIUM_KEY: set this to your premium id to enable premium content
DI_FM_TITLE_ONLY : set this to 1 to only display song titles
```

The channel list is updated once a day. To force a refresh, delete `/tmp/di_channel_list`.

The script enables tab-completion for channel names.

### soma.fish

Similar thing for somafm.com. No channel listing cuz hard. It also recognizes some environment variables:

```
SOMA_TITLE_ONLY : set this to 1 to only display song titles
```

### ip.fish

Various ways to get info about your current IP.

### rm.fish

A safe rm that moves things to ~/.Trash.

