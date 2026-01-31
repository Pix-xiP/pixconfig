# Umbral Serenity Colours and Styling for Tmux

set -g mode-style "fg=#c081fa,bg=#0b0b14"

set -g message-style "fg=#c081fa,bg=#0b0b14"
set -g message-command-style "fg=#c081fa,bg=#0b0b14"

set -g pane-border-style "fg=#0b0b14"
set -g pane-active-border-style "fg=#c081fa"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#c081fa,bg=#111119"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#0b0b14,bg=#c081fa,bold] SESH:#S #T #[fg=#c081fa,bg=#111119,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#111119,bg=#111119,nobold,nounderscore,noitalics]#[fg=#c081fa,bg=#111119] #{prefix_highlight} #[fg=#0b0b14,bg=#111119,nobold,nounderscore,noitalics]#[fg=#c081fa,bg=#0b0b14,bold] %Y-%m-%d    #[fg=#0b0b14,bg=#c081fa,bold]  #(whoami)@#h "

setw -g window-status-activity-style "underscore,fg=#dfb7e8,bg=#111119"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#dfb7e8,bg=#111119"
setw -g window-status-format "#[fg=#111119,bg=#111119,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#111119,bg=#111119,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#111119,bg=#c081fa,nobold,nounderscore,noitalics]#[fg=#0b0b14,bg=#c081fa,bold] #I  #W #F #[fg=#c081fa,bg=#111119,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#f1c4e0]#[bg=#111119]#[fg=#111119]#[bg=#f1c4e0]"
set -g @prefix_highlight_output_suffix ""
