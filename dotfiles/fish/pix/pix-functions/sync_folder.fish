function sync_folder --description "Syncs a folder with a remote server" -a FOLDER REMOTE REMOTE_PATH
    rsync -azuvP $FOLDER $REMOTE:$REMOTE_PATH
end
