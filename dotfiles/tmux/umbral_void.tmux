# Umbral Colours and Styling for Tmux

set -g mode-style "fg=#7644fa,bg=#0a0214"

set -g message-style "fg=#7644fa,bg=#0a0214"
set -g message-command-style "fg=#7644fa,bg=#0a0214"

set -g pane-border-style "fg=#0a0214"
set -g pane-active-border-style "fg=#7644fa"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#7644fa,bg=#151022"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#15161e,bg=#7644fa,bold] SESH:#S #T #[fg=#7644fa,bg=#151022,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#151022,bg=#151022,nobold,nounderscore,noitalics]#[fg=#7644fa,bg=#151022] #{prefix_highlight} #[fg=#0a0214,bg=#151022,nobold,nounderscore,noitalics]#[fg=#7644fa,bg=#0a0214,bold] %Y-%m-%d    #[fg=#15161e,bg=#7644fa,bold]  #(whoami)@#h "

setw -g window-status-activity-style "underscore,fg=#9971c1,bg=#151022"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#9971c1,bg=#151022"
setw -g window-status-format "#[fg=#151022,bg=#151022,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#151022,bg=#151022,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#151022,bg=#7644fa,nobold,nounderscore,noitalics]#[fg=#0a0214,bg=#7644fa,bold] #I  #W #F #[fg=#7744fa,bg=#151022,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#ffd369]#[bg=#151022]#[fg=#151022]#[bg=#ffd369]"
set -g @prefix_highlight_output_suffix ""
