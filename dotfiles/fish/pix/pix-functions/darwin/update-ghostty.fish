function update_ghostty --description "Automatically updates the Ghostty Terminal"
    pushd ~/AdeptusCustodes/Talassar/ghostty
    echo "Running ghostty build."
    git pull
    zig build -Doptimize=ReleaseFast
    cd macos && xcodebuild
    echo "Done building"
    popd
end
