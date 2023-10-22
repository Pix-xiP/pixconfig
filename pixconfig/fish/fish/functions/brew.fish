

function brew -d "Updates Sketchybar after brew is run, auto trigger"
  command brew $argv
  sketchybar --trigger brew_update
end

