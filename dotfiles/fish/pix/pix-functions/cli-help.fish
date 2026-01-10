# Attempt to open a URL to the Documentation or Quick help 
# of a given command line program listed here

function cli-help -d "spawn help of given input" -a tool
    switch $tool
        case yazi
            open https://yazi-rs.github.io/docs/quick-start
        case nvim
            open https://neovim.io/doc/
        case fzf
            echo "\
Quick View of how to search in FZF

  Token   | Match type                  | Description
  ========|=============================|===================================
  sbtrkt  | fuzzy-match                 | Items that match sbtrkt
  'wild   | exact-match (quoted)        | Items that include wild
  ^music  | prefix-exact-match          | Items that start with music
  .mp3\$   | suffix-exact-match          | Items that end with .mp3
  !fire   | inverse-exact-match         | Items that do not include fire
  !^music | inverse-prefix-exact-match  | Items that do not start with music
  !.mp3\$  | inverse-suffix-exact-match  | Items that do not end with .mp3
      "
        case "*" help
            echo "\
No help found. Valid options include:
    -> yazi 
    -> nvim
    -> fzf
"

    end
end
