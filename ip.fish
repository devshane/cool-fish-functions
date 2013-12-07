function ip
    #curl ifconfig.me
    #curl ifcfg.net
    curl "http://ipinfo.io/$argv"
end
