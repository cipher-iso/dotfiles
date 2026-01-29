#!/usr/bin/env bash

# ===================== PATHS =====================
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_CONF="$DOTFILES_DIR/DotfilesPKG.conf"
CONFIG_FILE="$DOTFILES_DIR/Scripts/Dotfiles.conf"
SOURCE_ENV="$DOTFILES_DIR/.config/hypr/Config/Environment.conf"
ENV_FILE="$HOME/.config/hypr/Config/Environment.conf"

# ===================== FUNCTIONS =====================
print_gradient() {
  local b_start=64 b_end=153 i=0 total=$1
  while IFS= read -r line; do
    local b=$((b_end - (b_end-b_start)*i/(total-1)))
    printf "\e[38;2;0;255;%dm%s\e[0m\n" "$b" "$line"
    ((i++))
  done
}

ok()   { echo -e "\033[1m\033[38;2;0;255;64m[  > $1 ]\033[0m"; }
fail() { echo -e "\033[1m\033[38;2;255;64;64m[  > $1 ]\033[0m"; }

prompt() {
  read -rp "$(echo -e "\033[1m\033[38;2;0;255;64m[ $1 - <Y/n> ]\033[0m")" r
  [[ -z $r || $r =~ ^[Yy]$ ]]
}

# ===================== SUDO =====================
export SUDO_PROMPT=$'\e[1;38;2;0;255;64m  > ENTER PASSPHRASE: \e[0m'
sudo -v || exit 1
( while sudo -n true; do sleep 60; done ) 2>/dev/null &

# ===================== INPUT VALIDATION =====================
[[ -f $CONFIG_FILE ]] || { fail "DOTFILES.CONF NOT FOUND"; exit 1; }
[[ -f $PKG_CONF ]] || { fail "DotfilesPKG.conf NOT FOUND"; exit 1; }
[[ -f $SOURCE_ENV ]] || { fail "SOURCE Environment.conf NOT FOUND"; exit 1; }

mapfile -t DOTFILES < <(grep -vE '^\s*#|^\s*$' "$CONFIG_FILE")

# ===================== PACKAGES =====================
PACMAN_PKGS=($(awk '/^# PACMAN PKG/{f=1;next}/^#/{f=0} f && NF' "$PKG_CONF"))
AUR_PKGS=($(awk '/^# AUR PKG/{f=1;next}/^#/{f=0} f && NF' "$PKG_CONF"))

PAC_OK=0; PAC_FAIL=()
AUR_OK=0; AUR_FAIL=()
DIR_OK=0; DIR_FAIL=()

# ===================== TOP ASCII =====================
printf "%s\n" "┏┳━  ┓ ┏┏┓┓ ┏┓┏┓┳┳┓┏┓  ┏┳┓┏┓  ┏┓┳┏┓┓┏┏┓┳┓  ┏┓┏┓  ━┳┓
┃┃   ┃┃┃┣ ┃ ┃ ┃┃┃┃┃┣    ┃ ┃┃  ┃ ┃┃┃┣┫┣ ┣┫━━┃┃┗┓   ┃┃
┗┻━  ┗┻┛┗┛┗┛┗┛┗┛┛ ┗┗┛   ┻ ┗┛  ┗┛┻┣┛┛┗┗┛┛┗  ┗┛┗┛  ━┻┛" | print_gradient 3

# ===================== INSTALL PACKAGES =====================
prompt "INSTALL REPOSITORIES?" && {

  for p in "${PACMAN_PKGS[@]}"; do
    if pacman -Qi "$p" &>/dev/null; then
      ((PAC_OK++))
    elif sudo pacman -S --needed --noconfirm "$p"; then
      ((PAC_OK++))
    else
      PAC_FAIL+=("$p")
    fi
  done

  if command -v yay &>/dev/null; then
    for p in "${AUR_PKGS[@]}"; do
      if yay -Qi "$p" &>/dev/null; then
        ((AUR_OK++))
      elif yay -S --needed --noconfirm "$p"; then
        ((AUR_OK++))
      else
        AUR_FAIL+=("$p")
      fi
    done
  else
    AUR_FAIL+=("${AUR_PKGS[@]}")
  fi
}

# ===================== NVIDIA INSTALL =====================
printf "%s\n" "┏┳━  ┳┓╻┓╻┓┳┓┳┏┓  ┓┳┓┏┓┏┳┓┏┓┓ ┓   ━┳┓
┃┃   ┃┃┃┃┃┃┃┃┃┣┫  ┃┃┃┗┓ ┃ ┣┫┃ ┃    ┃┃
┗┻━  ┛┗┛┗┛┻┻┛┻┛┗  ┻┛┗┗┛ ┻ ┛┗┗┛┗┛  ━┻┛" | print_gradient 3

prompt "INSTALL NVIDIA PACKAGES?" && NVIDIA_INSTALL=1 || NVIDIA_INSTALL=0

[[ $NVIDIA_INSTALL -eq 1 ]] &&
  sudo pacman -S --needed nvidia-utils lib32-nvidia-utils egl-wayland

# ===================== INSTALL DOTFILES =====================
prompt "INSTALL ALL DOTFILES?" && {

  for d in "${DOTFILES[@]}"; do
    target="${d/\$HOME/$HOME}"
    source="$DOTFILES_DIR${target#$HOME}"

    if [[ -e $source ]]; then
      rm -rf "$target"
      mkdir -p "$(dirname "$target")"
      cp -a "$source" "$target" && ((DIR_OK++)) || DIR_FAIL+=("$target")
    else
      DIR_FAIL+=("$target")
    fi
  done

  mkdir -p "$(dirname "$ENV_FILE")"
  cp -a "$SOURCE_ENV" "$ENV_FILE"

  [[ $NVIDIA_INSTALL -eq 0 ]] &&
    sed -i '/^# NVIDIA SETTINGS/,/^$/d' "$ENV_FILE"
}

# ===================== END ASCII =====================
printf "%s\n" "┏┳━  •┳┓┏┓┏┳┓┏┓┓ ┓  ┏┓┓┏  ┏┓┏┓┳┳┓┏┓┓ ┏┓┏┳┓┏┓  ━┳┓
┃┃   ┓┃┃┗┓ ┃ ┣┫┃ ┃  ┗┓┣┫  ┃ ┃┃┃┃┃┃┃┃ ┣  ┃ ┣    ┃┃
┗┻━  ┗┛┗┗┛ ┻ ┛┗┗┛┗┛•┗┛┛┗  ┗┛┗┛┛ ┗┣┛┗┛┗┛ ┻ ┗┛  ━┻┛" | print_gradient 3

# ===================== SUMMARY =====================
echo
ok "$PAC_OK PACMAN PACKAGES COMPLETE"
for p in "${PAC_FAIL[@]}"; do fail "PACMAN: $p FAILED"; done

ok "$AUR_OK AUR PACKAGES COMPLETE"
for p in "${AUR_FAIL[@]}"; do fail "AUR: $p FAILED"; done

ok "$DIR_OK DOTFILES INSTALLED"
for d in "${DIR_FAIL[@]}"; do fail "DOTFILE: $d FAILED"; done

# ===================== REBOOT =====================
read -rp "$(echo -e "\033[1m\033[38;2;234;255;0m[ INSTALLATION COMPLETE - REBOOT SYSTEM? - <Y/n> ]\033[0m")" r
[[ -z $r || $r =~ ^[Yy]$ ]] && sudo reboot
