# ⚡️ 2-STEP INSTALL! - [ RECOMMENDED ]
> [!CAUTION]  
> **[INSTALL.SH](https://github.com/cipher-iso/dotfiles/blob/main/install.sh)** IS **EXPERIMENTAL**<br>**[ USE AT YOUR OWN RISK! ]**<br>
>
> ### **STEP 1:**
> Download the [Install Script](https://github.com/cipher-iso/dotfiles/blob/main/install.sh) into your `$HOME` Directory<br><br>
> ### **STEP 2:**
> In Your Terminal:<br>`chmod +x ~/install.sh && ~/install.sh`<br>
<br/>

# 📦 NECESSARY PACKAGES

> [!IMPORTANT]  
> ### **[These Packages](https://github.com/cipher-iso/dotfiles/blob/main/DotPKG.conf)** are **Required** for Dotfiles to Function.<br>
> Ignoring this may result in a broken config or non-functional features.
> <br><br>
> <details>
> <summary>📋 <ins>Package List:<ins></summary>  
> 
> ### 📘 PACMAN PACKAGES:<br>
> `sudo pacman -S --needed hyprland hypridle waybar kitty swayosd swaync hyprlock hyprsunset pavucontrol-qt blueman mpv easyeffects dolphin btop vivaldi wl-clip-persist hyprcursor mate-polkit nwg-look kvantum qt5ct gtk3 gtk4 neovim pipewire wireplumber xdg-desktop-portal cava cpio cmake pkg-config git gcc discord hyprshot hyprpicker steam mousepad calf lsp-plugins-lv2 zam-plugins-lv2 mda.lv2 yelp ttf-jetbrains-mono ttf-jetbrains-mono-nerd cairo hyprgraphics hyprlang hyprutils hyprwayland-scanner mesa pam pango sdbus-cpp xorg-xwayland wayland-protocols archlinux-xdg-menu`<br>
> ### 📙 AUR PACKAGES:<br>
> `yay -S --needed nmgui-bin waypaper qimgv-git kew xwaylandvideobridge qt6ct-kde vicinae swww`
> </details>
<br>

# ✨ WAYBAR AUTO-HIDE
> [!TIP]
> ### Looking for Waybar-Autohide only? [Click Here!](https://github.com/cipher-iso/Waybar-Autohide)<br>
> This is a stand-alone auto-hide script for Waybar!<br>*[Made for Hyprland]*
> 
> ![Preview](https://raw.githubusercontent.com/cipher-xui/Waybar-Autohide/main/Preview.gif)
<br>

# 🛠️ MANUAL INSTALLATION
### **STEP 1: [ CLONE THIS REPO ]**
In Your Terminal:<br>`git clone https://github.com/cipher-iso/dotfiles.git`<br><br>
### **STEP 2: [ INSTALL PACKAGES ]**
Install the [Necessary Packages](https://github.com/cipher-iso/dotfiles?tab=readme-ov-file#-necessary-packages) Listed in [DotPKG.conf](https://github.com/cipher-iso/dotfiles/blob/main/DotPKG.conf)<br><br>
### **STEP 3: [ INSTALL PLUGINS ]**
In Your Terminal:<br>`hyprpm update`<br>`hyprpm add hyprpm add https://github.com/hyprwm/hyprland-plugins`<br>`hyprpm enable hyprexpo` <br><br>
### **STEP 4: [ IMPORT DOTFILES ]**
In Your Terminal:<br>`rsync -r --remove-source-files --exclude='{.gitignore,README.md,install.sh,DotPKG.conf,DotDIR.conf}' ~/dotfiles/ ~/`<br><br>This will import Dotfiles, whilst ignoring git files.<br>Otherwise, paste [each Directory](https://github.com/cipher-iso/dotfiles/blob/main/DotDIR.conf) in your `$HOME` - [ `SLO` & `.bashrc` Optional ] <br><br>
