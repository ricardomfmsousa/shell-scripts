# tmux terminal
set -g default-terminal "screen-256color"
set-option -ga terminal-overrides ",st-256color:Tc"

# tmux terminal cursor override
set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on

# Escape delay
set -sg escape-time 0

# Mouse scroll
setw -g mouse on
setw -g mode-keys vi
bind-key -t vi-copy y copy-pipe "xclip -sel clip -i"
unbind -t vi-copy MouseDragEnd1Pane
bind-key -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if-shell -F -t = '#{pane_in_mode}' 'send-keys -t = H 5 k' 'copy-mode -e'"
bind-key -n WheelDownPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if-shell -F -t = '#{pane_in_mode}' 'send-keys -t = L 5 j'"

# key mappings
# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-e
bind-key C-e send-prefix

# new window with cwd
bind c new-window -c "#{pane_current_path}"

# split panes using h and v
bind v split-window -h -c '#{pane_current_path}'
bind h split-window -v -c '#{pane_current_path}'
unbind '"'
unbind %

# Shift arrow to switch windows
bind -n C-Left  previous-window
bind -n C-Right next-window

######################
### DESIGN CHANGES ###
######################

# panes
set -g pane-border-fg black
set -g pane-active-border-fg brightred

## Status bar design
# status line
set -g status-justify left
set -g status-bg black
set -g status-fg colour12
set -g status-interval 2

# messaging
set -g message-fg black
set -g message-bg yellow
set -g message-command-fg blue
set -g message-command-bg black

#window mode
setw -g mode-bg colour6
setw -g mode-fg colour0

# window status
setw -g window-status-format " #F#I:#W#F "
setw -g window-status-current-format " #F#I:#W#F "
setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
setw -g window-status-current-bg colour0
setw -g window-status-current-fg colour11
setw -g window-status-current-attr dim
setw -g window-status-bg green
setw -g window-status-fg black
setw -g window-status-attr reverse

# Info on left (I don't have a session display for now)
set -g status-left ''

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

# The panes {
set -g pane-border-fg colour238
set -g pane-active-border-fg colour4
# }

# The statusbar {
set -g status-position bottom
set -g status-bg black
set -g status-fg white
set -g status-attr dim
set -g status-left ''
set -g status-right ''

setw -g window-status-current-fg colour4
setw -g window-status-current-bg colour238
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour4]:#[fg=white]#W#[fg=colour4]#F '

setw -g window-status-fg colour138
setw -g window-status-bg colour0
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour138]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# }
# The messages {
set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour166

# }