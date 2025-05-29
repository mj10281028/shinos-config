#!/bin/bash

# Script : install_shinos.sh
# But : Reproduire exactement la config ShinOS sur un nouvel appareil
# A lancer depuis ~/shinos-config (copié à la racine du /home/NOM_UTILISATEUR)

# ✔ Installer les paquets requis
sudo apt update && sudo apt install -y \
    i3 \
    xfce4 \
    rofi \
    picom \
    feh \
    mousepad \
    lxterminal \
    git

# ✔ Copier les fichiers de configuration dans ~/.config
mkdir -p ~/.config
cp -r ./config/i3 ~/.config/
cp -r ./config/rofi ~/.config/
cp -r ./config/picom ~/.config/
cp -r ./config/xfce4 ~/.config/
sudo cp /.config/rofi/themes/style_1.rasi /usr/share/rofi/themes/
sudo cp ~/shinos-config/assets/ShinOS.png /usr/share/backgrounds/
sudo cp ~/shinos-config/lightdm-gtk-greeter.conf /etc/lightdm/

# ✔ Appliquer le fond d'écran ShinOS (si i3 est utilisé)
feh --bg-fill ~/.config/i3/wallpapers/shinos-wallpaper.jpg

# ✔ Lancer picom avec transparence (si i3 est utilisé)
# (ajout également dans config i3 normalement)
pkill picom
picom --config ~/.config/picom/picom.conf &

# ✔ Rendre les changements persistants : aucune action à faire si configs i3 et xfce4 sont bien copiées

# ✔ Nettoyage (optionnel)
echo -e "\nShinOS a été installé avec succès. Redémarrez pour appliquer tous les changements."

exit 0
