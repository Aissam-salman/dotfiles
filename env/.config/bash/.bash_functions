# -------------------------
# OPEN FUNCTION (from omarchy)
# -------------------------
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# -------------------------
# COMPRESSION (from omarchy)
# -------------------------
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# -------------------------
# SD CARD & DRIVE UTILITIES (from omarchy)
# -------------------------
# Write iso file to sd card
iso2sd() {
  if [ $# -ne 2 ]; then
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    echo -e "\nAvailable SD cards:"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    sudo eject $2
  fi
}

# Format an entire drive for a single partition using exFAT
format-drive() {
  if [ $# -ne 2 ]; then
    echo "Usage: format-drive <device> <name>"
    echo "Example: format-drive /dev/sda 'My Stuff'"
    echo -e "\nAvailable drives:"
    lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
  else
    echo "WARNING: This will completely erase all data on $1 and label it '$2'."
    read -rp "Are you sure you want to continue? (y/N): " confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      sudo wipefs -a "$1"
      sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
      sudo parted -s "$1" mklabel gpt
      sudo parted -s "$1" mkpart primary 1MiB 100%

      partition="$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
      sudo partprobe "$1" || true
      sudo udevadm settle || true

      sudo mkfs.exfat -n "$2" "$partition"

      echo "Drive $1 formatted as exFAT and labeled '$2'."
    fi
  fi
}

# -------------------------
# VIDEO TRANSCODING (from omarchy)
# -------------------------
# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
  ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}

# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
  ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}

# -------------------------
# IMAGE TRANSCODING (from omarchy)
# -------------------------
# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
  img="$1"
  shift

  magick "$img" $@ -quality 95 -strip ${img%.*}-optimized.jpg
}

# Transcode any image to JPG image that's great for sharing online without being too big
img2jpg-small() {
  img="$1"
  shift

  magick "$img" $@ -resize 1080x\> -quality 95 -strip ${img%.*}-optimized.jpg
}

# Transcode any image to compressed-but-lossless PNG
img2png() {
  img="$1"
  shift

  magick "$img" $@ -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${img%.*}-optimized.png"
}

# -------------------------
# FZF NAVIGATION (custom)
# -------------------------
# Alt-f pour navigation intelligente avec fzf
smart_fzf_nav() {
    local selected

    # Recherche dans les chemins configurés
    # Combine fichiers et dossiers avec preview intelligent
    selected=$(for path in $FZF_NAV_PATHS; do
        find "$path" -mindepth 1 \( -path '*/\.*' -o -path '*/node_modules/*' -o -path '*/.git/*' \) -prune -o -print 2>/dev/null
    done | sed "s|^$HOME|~|" | \
        fzf --height=80% \
            --layout=reverse \
            --border \
            --preview '[[ -d {} ]] && ls -lah --color=always {} || ([[ -f {} ]] && (bat --style=numbers --color=always {} 2>/dev/null || cat {}))' \
            --preview-window=right:60% \
            --bind 'ctrl-/:toggle-preview' \
            --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
            --header 'Enter=cd/open | Ctrl-/:toggle preview | Ctrl-d/u:scroll' | sed "s|^~|$HOME|")

    if [[ -n "$selected" ]]; then
        if [[ -d "$selected" ]]; then
            cd "$selected" && ls -la
        elif [[ -f "$selected" ]]; then
            ${EDITOR:-vi} "$selected"
        fi
    fi
}

# Alt-d pour navigation dans les dossiers uniquement
fzf_dir_nav() {
    local selected

    # Recherche uniquement les dossiers dans les chemins configurés
    selected=$(for path in ${FZF_NAV_PATHS:-. ~/Work}; do
        find "$path" -mindepth 1 -type d \( -path '*/\.*' -o -path '*/node_modules' -o -path '*/.git' \) -prune -o -type d -print 2>/dev/null
    done | sed "s|^$HOME|~|" | \
        fzf --height=80% \
            --layout=reverse \
            --border \
            --preview 'ls -lah --color=always {}' \
            --preview-window=right:60% \
            --bind 'ctrl-/:toggle-preview' \
            --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' \
            --header 'Enter=cd to directory | Ctrl-/:toggle preview' | sed "s|^~|$HOME|")

    if [[ -n "$selected" ]]; then
        cd "$selected" && ls -la
    fi
}

# -------------------------
# DIRECTORY UTILITIES (custom)
# -------------------------
# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

# -------------------------
# GIT UTILITIES (custom)
# -------------------------
# Git flow rapide
togit(){ git add . && git commit -m "$1" && git push; }
gall(){ git add . && git commit -m "${1:-'quick commit'}" && git push; }

# -------------------------
# DEVELOPMENT UTILITIES (custom)
# -------------------------
valgo(){ valgrind --leak-check=full --track-origins=yes ./"$1"; }

# Quick open/edit config
edit(){ $EDITOR ~/.config/$1/$2; }

# -------------------------
# TMUX SESSION MANAGEMENT (custom)
# -------------------------
# Fonction pour attacher à une session tmux existante
tma() {
    if [ -z "$1" ]; then
        # Si aucun nom n'est fourni, attacher à la dernière session
        tmux attach
    else
        # Attacher à une session spécifique par son nom
        tmux attach -t "$1"
    fi
}

# Fonction pour attacher ou créer une nouvelle session
tmn() {
    if [ -z "$1" ]; then
        echo "Usage: tmn <nom-de-session>"
        return 1
    fi

    # Attacher si elle existe, sinon créer une nouvelle session
    tmux attach -t "$1" 2>/dev/null || tmux new -s "$1"
}

# Liste toutes les sessions tmux
tms(){ tmux list-sessions; }
