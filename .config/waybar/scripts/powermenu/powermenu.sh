#!/bin/sh
# ~/.local/bin/powermenu.sh

# Define opciones con íconos (Font Awesome)
# \uF011 =  (power-off), \uF2F2 =  (restart), etc.
menu=$(printf "\tSalir\n\tReiniciar\n\tApagar\n\tSuspender\n\tHibernar")

# Mostrar menú con wofi centrado
chosen=$(echo -e "$menu" | wofi \
  --dmenu \
  --prompt="Apagar el sistema" \
  --insensitive \
  --allow-markup \
  --conf ~/.config/waybar/scripts/powermenu/powermenu.conf \
  --style ~/.config/waybar/scripts/powermenu/powermenu.css)

# Extraer solo la acción (sin ícono)
action=$(echo "$chosen" | cut -d$'\t' -f2)
s
case "$action" in
  "Salir")
    hyprctl dispatch exit
    ;;
  "Reiniciar")
    systemctl reboot
    ;;
  "Apagar")
    systemctl poweroff
    ;;
  "Suspender")
    systemctl suspend
    ;;
  "Hibernar")
    systemctl hibernate
    ;;
esac
