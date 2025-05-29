#!/bin/bash

# Script : install_shinos.sh
# But : Reproduire exactement la config ShinOS sur un PC standard
# À lancer depuis ~/shinos-config

# --- 1. Mise à jour système ---
echo "[1/7] Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# --- 2. Installation des paquets nécessaires ---
echo "[2/7] Installation des paquets..."
sudo apt install -y \
    i3 \
    xfce4 \
    lxterminal \
    picom \
    rofi \
    feh \
    mousepad \
    git \
    pulseaudio \
    pavucontrol \
    xinit \
    libglib2.0-bin \
    unzip \
    wget \
    flatpak \
    gnome-software-plugin-flatpak

# --- 3. Définir lxterminal comme terminal par défaut ---
echo "[3/7] Définition de lxterminal comme terminal par défaut..."
xfconf-query -c xsettings -p /DefaultTerminalEmulator -s lxterminal || true

# --- 4. Copier les fichiers de configuration personnalisés ---
echo "[4/7] Déploiement des fichiers de configuration..."
mkdir -p ~/.config
cp -r ./config/i3 ~/.config/
cp -r ./config/rofi ~/.config/
cp -r ./config/picom ~/.config/
cp -r ./config/xfce4 ~/.config/
sudo cp ./config/rofi/themes/style_1.rasi /usr/share/rofi/themes/
sudo cp ~/shinos-config/assets/ShinOS.png /usr/share/backgrounds/
sudo cp ~/shinos-config/lightdm-gtk-greeter.conf /etc/lightdm/

# --- 5. Appliquer le fond d’écran ---
echo "[5/7] Application du fond d'écran..."
feh --bg-fill ~/.config/i3/wallpapers/shinos-wallpaper.jpg

# --- 6. Lancer automatiquement l'environnement au démarrage ---
echo "[6/7] Configuration de l'autostart..."
echo "exec i3" > ~/.xinitrc

# --- 7. Installation de LibreWolf via Flatpak ---
echo "[7/7] Installation de LibreWolf..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.gitlab.librewolf-community

# --- 8. Forcer i3 comme session par défaut dans LightDM ---
echo -e "[User]\nXSession=i3" | sudo tee /var/lib/AccountsService/users/$USER > /dev/null

# --- Fin ---
echo -e "\n✅ ShinOS a été installé avec succès. Redémarre pour appliquer tous les changements."

exit 0
