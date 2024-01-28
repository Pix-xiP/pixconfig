#!/bin/bash

sketchybar  --add item discord right \
	          --set discord \
	                update_freq=20 \
	                script="$PLUGIN_DIR/discord.sh" \
	                background.padding_left=15 \
	                icon.font.size=18 \
	          --subscribe discord system_woke
