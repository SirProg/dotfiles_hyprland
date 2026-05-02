#!/bin/bash

# Usage: wallpaper.sh [static|animated|video]
# Default: static
MODE="${1:-static}"

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"
STATIC_DIR="$WALLPAPER_DIR/static"
ANIMATED_DIR="$WALLPAPER_DIR/animated"
VIDEO_DIR="$WALLPAPER_DIR/videos"

INTERVAL=120  # seconds between wallpaper changes (static & animated)

# Transition settings (solo para modo static)
TRANSITION_TYPE="fade"      # fade | wave | wipe | grow | outer | random
TRANSITION_DURATION="1.5"
TRANSITION_FPS="60"
TRANSITION_BEZIER=".43,1.19,1,.4"

# ── Helpers ──────────────────────────────────────────────────────────────────

start_awww() {
    pkill awww-daemon 2>/dev/null
    sleep 0.2
    awww-daemon &
    awww wait
}

stop_all() {
    pkill awww-daemon 2>/dev/null
    pkill mpvpaper    2>/dev/null
    sleep 0.2
}

# ── Modos ────────────────────────────────────────────────────────────────────

mode_static() {
    if [[ -z "$(find "$STATIC_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) 2>/dev/null)" ]]; then
        echo "wallpaper.sh: no hay imágenes en $STATIC_DIR"
        exit 1
    fi

    stop_all
    start_awww

    LAST=""
    while true; do
        WALLPAPER=$(find "$STATIC_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) \
            | grep -v "$LAST" | shuf -n 1)

        [[ -z "$WALLPAPER" ]] && \
            WALLPAPER=$(find "$STATIC_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) \
            | shuf -n 1)

        awww img "$WALLPAPER" \
            --transition-type     "$TRANSITION_TYPE" \
            --transition-duration "$TRANSITION_DURATION" \
            --transition-fps      "$TRANSITION_FPS" \
            --transition-bezier   "$TRANSITION_BEZIER"

        LAST="$WALLPAPER"
        sleep "$INTERVAL"
    done
}

mode_animated() {
    if [[ -z "$(find "$ANIMATED_DIR" -maxdepth 1 -type f -name "*.gif" 2>/dev/null)" ]]; then
        echo "wallpaper.sh: no hay GIFs en $ANIMATED_DIR"
        exit 1
    fi

    stop_all
    start_awww

    LAST=""
    while true; do
        WALLPAPER=$(find "$ANIMATED_DIR" -maxdepth 1 -type f -name "*.gif" \
            | grep -v "$LAST" | shuf -n 1)

        [[ -z "$WALLPAPER" ]] && \
            WALLPAPER=$(find "$ANIMATED_DIR" -maxdepth 1 -type f -name "*.gif" | shuf -n 1)

        awww img "$WALLPAPER" \
            --transition-type     fade \
            --transition-duration 1 \
            --transition-fps      60

        LAST="$WALLPAPER"
        sleep "$INTERVAL"
    done
}

mode_video() {
    if ! command -v mpvpaper &>/dev/null; then
        echo "wallpaper.sh: mpvpaper no está instalado."
        echo "Instálalo con: yay -S mpvpaper"
        exit 1
    fi

    if [[ -z "$(find "$VIDEO_DIR" -maxdepth 1 -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.mkv" \) 2>/dev/null)" ]]; then
        echo "wallpaper.sh: no hay videos en $VIDEO_DIR"
        exit 1
    fi

    stop_all

    VIDEO=$(find "$VIDEO_DIR" -maxdepth 1 -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.mkv" \) \
        | shuf -n 1)

    echo "wallpaper.sh: reproduciendo $VIDEO"
    mpvpaper -o "loop no-audio" '*' "$VIDEO"
}

# ── Dispatcher ───────────────────────────────────────────────────────────────

case "$MODE" in
    static)   mode_static   ;;
    animated) mode_animated ;;
    video)    mode_video    ;;
    *)
        echo "Uso: wallpaper.sh [static|animated|video]"
        echo "  static   — imágenes en wallpapers/static/   (JPG, PNG)"
        echo "  animated — GIFs en      wallpapers/animated/ (GIF)"
        echo "  video    — videos en    wallpapers/videos/   (MP4, WebM, MKV)"
        exit 1
        ;;
esac
