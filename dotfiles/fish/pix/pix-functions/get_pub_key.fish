function get_pub_key --description "Quickly cat out public file"
    set -q KEY_PATH; and /bin/cat "$KEY_PATH"; or echo "Variable \$KEY_PATH not set"
end
