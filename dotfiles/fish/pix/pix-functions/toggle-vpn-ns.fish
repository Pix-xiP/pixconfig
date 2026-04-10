function toggle-vpn-ns
    sudo sed -Ei '/^#? ?nameserver 10\.0\.0\.243$/ {
		/^#/ s/^# ?//
		t
		s/^/# /
	}' $argv
end
