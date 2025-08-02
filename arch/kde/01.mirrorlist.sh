sudo reflector --country China --protocol https --sort rate --save /etc/pacman.d/mirrorlist --latest 3
sudo pacman -S reflector rsync
