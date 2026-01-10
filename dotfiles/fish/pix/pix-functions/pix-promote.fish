function pix-promote --argument func_name --description "Saves a live function to the pix-functions folder"
    if test -z "$func_name"
        echo "Usage: pix-promote [function_name]"
        return 1
    end

    set -l target_dir "$__fish_config_dir/pix/pix-functions"
    set -l target_file "$target_dir/$func_name.fish"

    if not functions -q $func_name
        echo "Error: Function '$func_name' does not exist in this session."
        return 1
    end

    functions $func_name >$target_file

    echo "Successfully promoted '$func_name' to $target_file"
end
