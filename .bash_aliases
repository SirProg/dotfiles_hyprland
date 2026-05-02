# cd aliases
alias ..='cd ..'
alias ...='cd ../..'

# nvim aliases
alias nv='nvim'

# ls aliases
alias la='ls -a'
alias lt='ls -t'
alias li='ls -l'

# mkdir aliases
mkdcd(){
  mkdir -p "$1"; cd "$1";
}

# exit aliases
alias ex='exit'

# clear aliases
alias cls='clear'

# waybar
alias waybar-reload='pkill waybar; sleep 0.3; hyprctl dispatch exec waybar'

# wallpaper
alias wp-static='pkill awww-daemon; pkill mpvpaper; ~/.config/hypr/scripts/wallpaper.sh static &'
alias wp-animated='pkill awww-daemon; pkill mpvpaper; ~/.config/hypr/scripts/wallpaper.sh animated &'
alias wp-video='pkill awww-daemon; pkill mpvpaper; ~/.config/hypr/scripts/wallpaper.sh video &'
