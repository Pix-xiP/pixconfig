function fzf-match
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
end
