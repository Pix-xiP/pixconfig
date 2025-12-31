function _tide_item_discord
    set d (lsappinfo info -only StatusLabel 'Discord' | awk -F '"' '{print $6}')
    if ! string match $d -q "•"
        _tide_print_item discord $tide_discord_icon ' ' $d
    end
end
