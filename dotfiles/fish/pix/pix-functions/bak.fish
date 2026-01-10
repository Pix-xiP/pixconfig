function bak --argument filename --description "Makes a very quick in place backup of a file or directory"
    cp -vr $filename $filename.bak
end
