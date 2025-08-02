#!/bin/bash
sudo pacman -S reflector rsync
sudo reflector --country China --protocol https --sort rate --save /etc/pacman.d/mirrorlist --latest 5
