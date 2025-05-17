!#/usr/bin/bash

utilpath=~/.config/utilfiles
echo -e "\e[31mCreating folder for necessary files: $utilpath\e[0m"
mkdir $utilpath
cp ~/hyprarchutils/10-14-Day-Thumb.jpg $utilpath
cp ~/hyprarchutils/A_black_image.jpg $utilpath
cp ~/hyprarchutils/PIA23803.png $utilpath
cp ~/hyprarchutils/ayu-mirage.json $utilpath

echo -e "\e[31mInstalling yay...\e[0m"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

echo -e "\e[31mInstalling Hyprland...\e[0m"
sudo pacman -S hyprland

echo -e "\e[31mInstalling Hyprland ecosystem...\e[0m"
yay -S aquamarine hyprlang hyprcursor bibata-cursor-theme hyprutils hyprgraphics --sudoloop --noconfirm

echo -e "\e[31mInstalling must-have software...\e[0m"
yay -S mako kitty clipse walker fastfetch dolphin superfile-bin waybar jq socat brightnessctl playerctl neovim btop tlp xorg-server hyprpolkitagent qt5-wayland qt6-wayland hyprpicker hypridle hyprlock hyprsysteminfo hyprland-qt-support --sudoloop --noconfirm

echo -e "\e[31mInstalling audio software...\e[0m"
yay -S pipewire wireplumber pipewire-jack easyeffects --sudoloop --noconfirm

echo -e "\e[31mInstalling Zsh + Oh My Posh...\e[0m"
yay -S zsh
chsh -s $(which zsh)
echo -e "\e[31m$($SHELL --version) installed\e[0m"
curl -s https://ohmyposh.dev/install.sh | bash -s

echo -e "\e[31mInstalling brew...\e[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo -e "\e[31mInstalling misc dotfiles from cooperbousum/dotfiles using chezmoi...\e[0m"
yay -S chezmoi --sudoloop --noconfirm
chezmoi init --apply https://github.com/cooperbousum/dotfiles.git

echo -e "\e[31mInstalling wal with ayu-mirage\e[0m"
yay -S pywal --sudoloop --noconfirm
wal -f $utilpath/ayu-mirage.json

fontpath=/usr/share/fonts
echo -e "\e[31mInstalling fonts for waybar and hyprlock\e[0m"
mkdir $fontpath
mkdir $fontpath/OTF
mkdir $fontpath/TTF
cp ~/hyprarchutils/istok-web.bold.ttf $fontpath/TTF
cp ~/hyprarchutils/SFMono-Bold.otf $fontpath/OTF

echo -e "\e[31mDo you want to set up agreety with autologin to use hyprlock as a DE? Be sure that you have set the user in hyprachutils/confit.toml before running this. (y/n)\e[0m"
read -n 1 -r
echo # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  yay -S greetd --sudoloop --noconfirm
  systemctl enable greetd
  cp config.toml /etc/greetd
fi
