#!/bin/sh
echo
echo "Downgrading libx11, mesa, vulkan-radeon, llvm, to work with steam/VR"
echo "- Use this after a full system update"
echo

sudo pacman -U file:///var/cache/pacman/pkg/lib32-libx11-1.8.2-2-x86_64.pkg.tar.zst
sudo pacman -U file:///var/cache/pacman/pkg/libx11-1.8.2-2-x86_64.pkg.tar.zst

sudo pacman -U file:///var/cache/pacman/pkg/mesa-22.2.3-1-x86_64.pkg.tar.zst
sudo pacman -U file:///var/cache/pacman/pkg/lib32-mesa-22.2.3-1-x86_64.pkg.tar.zst

sudo pacman -U file:///var/cache/pacman/pkg/vulkan-radeon-22.2.3-1-x86_64.pkg.tar.zst
sudo pacman -U file:///var/cache/pacman/pkg/lib32-vulkan-radeon-22.2.3-1-x86_64.pkg.tar.zst

sudo pacman -U file:///var/cache/pacman/pkg/lib32-llvm-libs-14.0.6-3-x86_64.pkg.tar.zst
sudo pacman -U file:///var/cache/pacman/pkg/llvm-libs-14.0.6-4-x86_64.pkg.tar.zst
