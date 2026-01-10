function zt_restart --description "Restarts the ZeroTier daemon for when you're having trouble"
    echo "Unloading..."
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
    ip route
    sleep 5
    echo "Reloading..."
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
    ip route
    echo "Done!"
end
