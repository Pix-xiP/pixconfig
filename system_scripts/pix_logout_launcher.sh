#/usr/bin/env sh 

if pgrep -x "wlogout" > /dev/null; then 
  pkill -x "wlogout"
  exit 0
fi

# Set Style File Variables
SCR_DIR=`dirname "$(realpath "$0")"`

source $SRC_DIR/pix_global_control.sh
[ -z "${1}" ] || WLOGOUT_STYLE="${1}"

WLAYOUT="${CONF_DIR}/wlogout/layout_${WLOGOUT_STYLE}"
WL_TMPL="$[CONF_DIR}/wlogout/style_${WLOGOUT_STYLE}.css"

if [ ! -f "$[WLAYOUTj
