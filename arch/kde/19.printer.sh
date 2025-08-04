#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
sudo pacman -S cups
sudo systemctl start cups.service
sudo pacman -S system-config-printer
sudo pacman -S print-manager
