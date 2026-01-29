<p align="center">
  <img src="https://github.com/cipher-iso/dotfiles/blob/main/media/CIPHER-OS.png?raw=true" width="500" alt="CIPHER-OS LOGO"/>

<p align="center">
  <a href="https://github.com/cipher-iso/dotfiles?tab=readme-ov-file#%EF%B8%8F-manual-installation-%EF%B8%8F">INSTALLATION</a> • <a href="https://github.com/cipher-iso/dotfiles/tree/main/Scripts">SCRIPTS</a> • <a href="https://github.com/cipher-iso/Waybar-Autohide">WAYBAR AUTO-HIDE</a> • <a href="https://github.com/cipher-iso/dotfiles/blob/main/DotPKG.conf">PACKAGE LIST</a>
</p>
  
# <p align="center">⚡️ 2-STEP INSTALL! - [ RECOMMENDED ] ⚡️<br>
> [!CAUTION]  
> **[INSTALL.SH](https://github.com/cipher-iso/dotfiles/blob/main/install.sh)** IS **EXPERIMENTAL** - **[ USE AT YOUR OWN RISK! ]**<br>There is also a [Manual Installation](https://github.com/cipher-iso/dotfiles/tree/main#%EF%B8%8F-manual-installation-%EF%B8%8F) below.<br><br>
>
> ### **STEP 1:**
> Download the [Install Script](https://github.com/cipher-iso/dotfiles/blob/main/install.sh) into your `$HOME` Directory<br><br>
> ### **STEP 2:**
> In Your Terminal:<br>`chmod +x ~/install.sh && ~/install.sh`<br>
<br/>

# <p align="center">📦 NECESSARY PACKAGES 📦

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

# <p align="center">✨ WAYBAR AUTO-HIDE ✨
> [!TIP]
> ### Looking for Waybar-Autohide only? [Click Here!](https://github.com/cipher-iso/Waybar-Autohide)<br>
> This is a stand-alone auto-hide script for Waybar!<br>*[Made for Hyprland]*
> 
> ![Preview](https://raw.githubusercontent.com/cipher-xui/Waybar-Autohide/main/Preview.gif)
<br>

# <p align="center">🛠️ MANUAL INSTALLATION 🛠️
### **👥 | STEP 1: [ CLONE THIS REPO ]**
In Your Terminal:<br>`git clone https://github.com/cipher-iso/dotfiles.git`<br><br>
### **📥 | STEP 2: [ INSTALL PACKAGES ]**
Install the [Necessary Packages](https://github.com/cipher-iso/dotfiles?tab=readme-ov-file#-necessary-packages-) Listed in [DotPKG.conf](https://github.com/cipher-iso/dotfiles/blob/main/DotPKG.conf)<br><br>
### **🔌 | STEP 3: [ INSTALL PLUGINS ]**
In Your Terminal:<br>`hyprpm update`<br>`hyprpm add hyprpm add https://github.com/hyprwm/hyprland-plugins`<br>`hyprpm enable hyprexpo` <br><br>
### **🗃️ | STEP 4: [ IMPORT DOTFILES ]**
In Your Terminal:<br>`rsync -r --remove-source-files --exclude='{.gitignore,README.md,install.sh,DotPKG.conf,DotDIR.conf}' ~/dotfiles/ ~/`<br><br>This will import Dotfiles, whilst ignoring git files.<br>Otherwise, paste [each Directory](https://github.com/cipher-iso/dotfiles/blob/main/DotDIR.conf) in your `$HOME` - [ `SLO` & `.bashrc` Optional ] <br><br>
### **✅ | STEP 5: [ COMPLETE INSTALLATION ]**
Reboot your System for all Functions & Themeing to take Effect.<br>
