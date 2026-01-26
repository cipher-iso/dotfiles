#!/usr/bin/env bash

# INTERACTIVE DOTFILES INSTALLER
# -------------------------------

DOTFILES_DIR="$(pwd)"
CONFIG_FILE="$DOTFILES_DIR/Scripts/Dotfiles.conf"

# COLOR/BOLD
BOLD="\033[1m"
GREEN="\033[38;2;0;255;64m"
RESET="\033[0m"

# PACKAGE LISTS
PACMAN_PKGS=(
hyprland hypridle waybar kitty swayosd swaync hyprlock hyprsunset
pavucontrol-qt blueman mpv easyeffects dolphin btop vivaldi
wl-clip-persist hyprcursor mate-polkit nwg-look kvantum qt5ct
gtk3 gtk4 neovim pipewire wireplumber xdg-desktop-portal cava
)

YAY_PKGS=(
nmgui-bin waypaper qimgv-git kew xwaylandvideobridge-git qt6ct-kde
)

# PROMPT FUNCTION
prompt_confirm() {
	read -rp "$(echo -e "${BOLD}${GREEN}$1 [Y/n] ${RESET}")" response
	[[ -z "$response" || "$response" =~ ^[Yy]$ ]]
}

# CONFIG CHECK
if [ ! -f "$CONFIG_FILE" ]; then
	echo -e "${BOLD}${GREEN}Error: Dotfiles.conf not found${RESET}"
	exit 1
fi

# PACKAGE INSTALL (NO set -e HERE)
if prompt_confirm "Install packages"; then
	sudo pacman -S --needed "${PACMAN_PKGS[@]}" || true
	command -v yay &>/dev/null && yay -S --needed "${YAY_PKGS[@]}" || true
fi

# READ DOTFILES
mapfile -t DOTFILES < <(grep -vE '^\s*#|^\s*$' "$CONFIG_FILE")

# INSTALL EVERYTHING?
if prompt_confirm "Install everything"; then
	INSTALL_ALL=true
else
	INSTALL_ALL=false
fi

install_item() {
	local target="$1"
	local expanded="${target/\$HOME/$HOME}"
	local source="$DOTFILES_DIR${expanded#$HOME}"

	if [ ! -e "$source" ]; then
		echo -e "${BOLD}${GREEN}Skipping missing: $source${RESET}"
		return
	fi

	echo -e "${BOLD}${GREEN}Installing $expanded${RESET}"
	mkdir -p "$(dirname "$expanded")"
	cp -r "$source" "$expanded"
}

# INSTALL DOTFILES
for item in "${DOTFILES[@]}"; do
	if $INSTALL_ALL || prompt_confirm "Install $item"; then
		install_item "$item"
	fi
done

# REBOOT
if prompt_confirm "Done - Reboot now"; then
	sudo reboot
else
	echo -e "${BOLD}${GREEN}Done. Reboot later.${RESET}"
fi
