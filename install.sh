#!/usr/bin/env bash

# INTERACTIVE DOTFILES INSTALLER
# -------------------------------
# Installs dotfiles from this repo using Scripts/Dotfiles.conf
# Does NOT backup; user is responsible for backups

set -e

DOTFILES_DIR="$(pwd)"
CONFIG_FILE="$DOTFILES_DIR/Scripts/Dotfiles.conf"

# COLOR/BOLD
BOLD="\033[1m"
GREEN="\033[38;2;0;255;64m"
RESET="\033[0m"

# PROMPT FUNCTION
prompt_confirm() {
    local message="$1"
    local default="$2"
    default=${default:-Y}
    read -rp -e "$(echo -e "${BOLD}${GREEN}${message} [${default}/n] ${RESET}")" response
    response=${response:-$default}
    [[ "$response" =~ ^[Yy]$ ]]
}

# CHECK CONFIG FILE
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${BOLD}${GREEN}Error: $CONFIG_FILE not found!${RESET}"
    exit 1
fi

# READ CONFIG INTO ARRAY
mapfile -t DOTFILES < <(grep -vE '^\s*#|^\s*$' "$CONFIG_FILE")

# STEP 1: Install Everything?
if prompt_confirm "Install Everything" Y; then
    INSTALL_EVERYTHING=true
else
    INSTALL_EVERYTHING=false
fi

# FUNCTION TO INSTALL A SINGLE DOTFILE OR DIRECTORY
install_item() {
    local line="$1"
    target_path=$(eval echo "$line")
    source_path="$DOTFILES_DIR${target_path#$HOME}"

    if [ ! -e "$source_path" ]; then
        echo -e "${BOLD}${GREEN}Warning: $source_path does not exist in repo, skipping.${RESET}"
        return
    fi

    mkdir -p "$(dirname "$target_path")"
    cp -r "$source_path" "$target_path"
    echo -e "${BOLD}${GREEN}Installed $source_path -> $target_path${RESET}"
}

# INSTALL PROCESS
if [ "$INSTALL_EVERYTHING" = true ]; then
    for line in "${DOTFILES[@]}"; do
        install_item "$line"
    done
else
    for line in "${DOTFILES[@]}"; do
        DIR_NAME=$(eval echo "$line")
        if prompt_confirm "Install $DIR_NAME" Y; then
            install_item "$line"
        fi
    done
fi

# REBOOT PROMPT
if prompt_confirm "Done - Reboot now" Y; then
    echo -e "${BOLD}${GREEN}Rebooting...${RESET}"
    sudo reboot
else
    echo -e "${BOLD}${GREEN}Done! Reboot manually later to apply changes.${RESET}"
fi
