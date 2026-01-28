#!/usr/bin/env bash

# INTERACTIVE DOTFILES INSTALLER
# -------------------------------
# Uses Scripts/Dotfiles.conf
# NO backups
# FORCE overwrites listed files/directories only
# Package failures do NOT stop the script

DOTFILES_DIR="$(pwd)"
CONFIG_FILE="$DOTFILES_DIR/Scripts/Dotfiles.conf"

# COLORS
BOLD="\033[1m"
GREEN="\033[38;2;0;255;64m"
RESET="\033[0m"

# PACKAGE LISTS
PACMAN_PKGS=(
hyprland hypridle waybar kitty swayosd swaync hyprlock hyprsunset pavucontrol-qt blueman mpv easyeffects dolphin btop vivaldi wl-clip-persist hyprcursor mate-polkit nwg-look kvantum qt5ct gtk3 gtk4 neovim pipewire wireplumber xdg-desktop-portal cava cpio cmake pkg-config git gcc discord hyprshot hyprpicker steam mousepad ttf-jetbrains-mono ttf-jetbrains-mono-nerd
)

YAY_PKGS=(
nmgui-bin waypaper qimgv-git kew xwaylandvideobridge qt6ct-kde vicinae
)

# PROMPT FUNCTION
prompt_confirm() {
	read -rp "$(echo -e "${BOLD}${GREEN}$1 [Y/n] ${RESET}")" reply
	[[ -z "$reply" || "$reply" =~ ^[Yy]$ ]]
}

# CONFIG CHECK
if [ ! -f "$CONFIG_FILE" ]; then
	echo -e "${BOLD}${GREEN}Error: Scripts/Dotfiles.conf not found${RESET}"
	exit 1
fi

# -------------------------------
# PACKAGE INSTALL (FAIL-SAFE)
# -------------------------------
if prompt_confirm "Install packages"; then
	echo -e "${BOLD}${GREEN}Installing pacman packages...${RESET}"
	sudo pacman -S --needed "${PACMAN_PKGS[@]}" || \
		echo -e "${BOLD}${GREEN}Warning: pacman install failed${RESET}"

	if command -v yay &>/dev/null; then
		echo -e "${BOLD}${GREEN}Installing AUR packages...${RESET}"
		yay -S --needed "${YAY_PKGS[@]}" || \
			echo -e "${BOLD}${GREEN}Warning: AUR install failed${RESET}"
	else
		echo -e "${BOLD}${GREEN}yay not found, skipping AUR packages${RESET}"
	fi
fi

# -------------------------------
# READ DOTFILES LIST
# -------------------------------
mapfile -t DOTFILES < <(grep -vE '^\s*#|^\s*$' "$CONFIG_FILE")

# INSTALL EVERYTHING?
if prompt_confirm "Install Everything"; then
	INSTALL_ALL=true
else
	INSTALL_ALL=false
fi

# -------------------------------
# INSTALL FUNCTION (FORCE REPLACE)
# -------------------------------
install_item() {
	local entry="$1"

	local target="${entry/\$HOME/$HOME}"
	local source="$DOTFILES_DIR${target#$HOME}"

	if [ ! -e "$source" ]; then
		echo -e "${BOLD}${GREEN}Skipping missing: $source${RESET}"
		return
	fi

	echo -e "${BOLD}${GREEN}Installing $target${RESET}"

	# REMOVE EXISTING TARGET ONLY
	if [ -e "$target" ]; then
		rm -rf "$target"
	fi

	# CREATE PARENT DIR ONLY
	mkdir -p "$(dirname "$target")"

	# COPY CLEAN VERSION
	cp -a "$source" "$target"
}

# -------------------------------
# DOTFILES INSTALL
# -------------------------------
for item in "${DOTFILES[@]}"; do
	if $INSTALL_ALL || prompt_confirm "Install $item"; then
		install_item "$item"
	fi
done

# -------------------------------
# HYPRPM PLUGINS
# -------------------------------
if command -v hyprpm &>/dev/null; then
	echo -e "${BOLD}${GREEN}Configuring Hyprland plugins...${RESET}"
	hyprpm update || echo -e "${BOLD}${GREEN}Warning: hyprpm update failed${RESET}"
	hyprpm add https://github.com/hyprwm/hyprland-plugins || \
		echo -e "${BOLD}${GREEN}Warning: plugin repo add failed${RESET}"
	hyprpm enable hyprexpo || \
		echo -e "${BOLD}${GREEN}Warning: hyprexpo enable failed${RESET}"
else
	echo -e "${BOLD}${GREEN}hyprpm not found, skipping Hyprland plugins${RESET}"
fi

# -------------------------------
# REBOOT PROMPT
# -------------------------------
if prompt_confirm "Done - Reboot now"; then
	echo -e "${BOLD}${GREEN}Rebooting...${RESET}"
	sudo reboot
else
	echo -e "${BOLD}${GREEN}Done. Reboot later to apply all changes.${RESET}"
fi
