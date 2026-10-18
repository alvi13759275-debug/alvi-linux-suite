#!/bin/bash

# Color Definitions
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[0;34m'
C_PURPLE='\033[0;35m'
C_CYAN='\033[0;36m'
C_RESET='\033[0m'

BASE_DIR="$HOME/alvi_distros"
BACKUP_DIR="$HOME/alvi_backups"
mkdir -p "$BASE_DIR" "$BACKUP_DIR"

show_banner() {
    clear
    echo -e "${C_BLUE}======================================================${C_RESET}"
    echo -e "${C_YELLOW}    🔥 ALVI ULTIMATE LINUX MASTER SUITE v3.0 🔥      ${C_RESET}"
    echo -e "${C_BLUE}======================================================${C_RESET}"
    echo -e "${C_GREEN}[+] Multi-Distro Environment & Diagnostic Central${C_RESET}"
    echo -e "${C_BLUE}------------------------------------------------------${C_RESET}"
}

# 🔍 Root Status & Environment Checker
check_root_status() {
    echo -e "${C_PURPLE}======================================================${C_RESET}"
    echo -e "${C_YELLOW}         🔍 ROOT STATUS & SYSTEM DIAGNOSTICS          ${C_RESET}"
    echo -e "${C_PURPLE}======================================================${C_RESET}"
    
    if command -v su &>/dev/null; then
        echo -e " [1] Native Android Root (su) : ${C_GREEN}[FOUND / ROOTED]${C_RESET}"
    else
        echo -e " [1] Native Android Root (su) : ${C_RED}[NOT FOUND / NON-ROOTED]${C_RESET}"
    fi

    if [ "$(id -u)" -eq 0 ]; then
        echo -e " [2] Current Execution User   : ${C_GREEN}root (UID: 0)${C_RESET}"
    else
        echo -e " [2] Current Execution User   : ${C_YELLOW}Standard User (UID: $(id -u))${C_RESET}"
    fi

    if [ -n "$PROOT_CANONICAL_PID" ] || [ -f "/.proot" ]; then
        echo -e " [3] PRoot Virtual Environment: ${C_GREEN}[ACTIVE]${C_RESET}"
    else
        echo -e " [3] PRoot Virtual Environment: ${C_CYAN}[INACTIVE / NATIVE TERMUX]${C_RESET}"
    fi

    if command -v getenforce &>/dev/null; then
        echo -e " [4] SELinux Status           : ${C_YELLOW}$(getenforce)${C_RESET}"
    fi
    echo -e "${C_PURPLE}======================================================${C_RESET}"
}

check_deps() {
    for pkg in proot wget tar xz-utils; do
        if ! command -v $pkg &>/dev/null; then
            pkg install $pkg -y >/dev/null 2>&1
        fi
    done
}

# 1. Kali Linux
install_kali() {
    local TARGET_DIR="$BASE_DIR/kali"
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${C_YELLOW}[*] Downloading Kali Linux RootFS...${C_RESET}"
        mkdir -p "$TARGET_DIR" && cd "$TARGET_DIR"
        wget -q --show-progress https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Kali/arm64/kali-rootfs-arm64.tar.xz -O kali.tar.xz
        tar -xf kali.tar.xz && rm kali.tar.xz
        echo "nameserver 8.8.8.8" > etc/resolv.conf
        echo 'export PS1="\[\033[1;31m\]┌──(\[\033[1;32m\]root💀kali\[\033[1;31m\])-[\[\033[0m\]\w\[\033[1;31m\]]\n└─\[\033[1;32m\]\# \[\033[0m\]"' >> root/.bashrc
    fi
    proot -0 -r "$TARGET_DIR" -b /dev -b /proc -b /sys -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=$TERM /bin/bash
}

# 2. Parrot OS
install_parrot() {
    local TARGET_DIR="$BASE_DIR/parrot"
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${C_YELLOW}[*] Downloading Parrot OS RootFS...${C_RESET}"
        mkdir -p "$TARGET_DIR" && cd "$TARGET_DIR"
        wget -q --show-progress https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Parrot/arm64/parrot-rootfs-arm64.tar.xz -O parrot.tar.xz
        tar -xf parrot.tar.xz && rm parrot.tar.xz
        echo "nameserver 8.8.8.8" > etc/resolv.conf
        echo 'export PS1="\[\033[1;36m\]┌─[\[\033[1;37m\]root@parrot\[\033[1;36m\]]-[\[\033[0m\]\w\[\033[1;36m\]]\n└─\[\033[1;33m\]# \[\033[0m\]"' >> root/.bashrc
    fi
    proot -0 -r "$TARGET_DIR" -b /dev -b /proc -b /sys -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=$TERM /bin/bash
}

# 3. Arch Linux
install_arch() {
    local TARGET_DIR="$BASE_DIR/arch"
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${C_YELLOW}[*] Downloading Arch Linux RootFS...${C_RESET}"
        mkdir -p "$TARGET_DIR" && cd "$TARGET_DIR"
        wget -q --show-progress https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Arch/arm64/arch-rootfs-arm64.tar.xz -O arch.tar.xz
        tar -xf arch.tar.xz && rm arch.tar.xz
        echo "nameserver 8.8.8.8" > etc/resolv.conf
        echo 'export PS1="\[\033[1;34m\][root@archlinux \W]\# \[\033[0m\]"' >> root/.bashrc
    fi
    proot -0 -r "$TARGET_DIR" -b /dev -b /proc -b /sys -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=$TERM /bin/bash
}

# 4. Ubuntu
install_ubuntu() {
    local TARGET_DIR="$BASE_DIR/ubuntu"
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${C_YELLOW}[*] Downloading Ubuntu RootFS...${C_RESET}"
        mkdir -p "$TARGET_DIR" && cd "$TARGET_DIR"
        wget -q --show-progress https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-arm64.tar.gz -O ubuntu.tar.gz
        tar -xf ubuntu.tar.gz && rm ubuntu.tar.gz
        echo "nameserver 8.8.8.8" > etc/resolv.conf
        echo 'export PS1="\[\033[1;32m\]root@ubuntu\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\# "' >> root/.bashrc
    fi
    proot -0 -r "$TARGET_DIR" -b /dev -b /proc -b /sys -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=$TERM /bin/bash
}

# 5. Debian
install_debian() {
    local TARGET_DIR="$BASE_DIR/debian"
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${C_YELLOW}[*] Downloading Debian RootFS...${C_RESET}"
        mkdir -p "$TARGET_DIR" && cd "$TARGET_DIR"
        wget -q --show-progress https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Debian/arm64/debian-rootfs-arm64.tar.xz -O debian.tar.xz
        tar -xf debian.tar.xz && rm debian.tar.xz
        echo "nameserver 8.8.8.8" > etc/resolv.conf
        echo 'export PS1="\[\033[1;31m\]root@debian\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\# "' >> root/.bashrc
    fi
    proot -0 -r "$TARGET_DIR" -b /dev -b /proc -b /sys -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=$TERM /bin/bash
}

# Utilities
backup_distro() {
    echo -e "${C_CYAN}[+] Available Distros for Backup:${C_RESET}"
    ls -1 "$BASE_DIR"
    read -p "Enter distro name to backup (e.g., kali, ubuntu): " d_name
    if [ -d "$BASE_DIR/$d_name" ]; then
        echo -e "${C_YELLOW}[*] Creating backup archive... Please wait.${C_RESET}"
        tar -czf "$BACKUP_DIR/${d_name}_backup_$(date +%F).tar.gz" -C "$BASE_DIR" "$d_name"
        echo -e "${C_GREEN}[+] Backup saved at: $BACKUP_DIR/${d_name}_backup_$(date +%F).tar.gz${C_RESET}"
    else
        echo -e "${C_RED}[!] Distro not found!${C_RESET}"
    fi
}

check_storage() {
    echo -e "${C_PURPLE}=== Distro Storage Usage Report ===${C_RESET}"
    du -sh "$BASE_DIR"/* 2>/dev/null || echo "No distros installed yet."
    echo -e "${C_PURPLE}===================================${C_RESET}"
}

remove_distro() {
    echo -e "${C_RED}[!] Available Distros to Remove:${C_RESET}"
    ls -1 "$BASE_DIR"
    read -p "Enter distro name to delete: " d_name
    if [ -d "$BASE_DIR/$d_name" ]; then
        read -p "Are you sure? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            rm -rf "$BASE_DIR/$d_name"
            echo -e "${C_GREEN}[+] Distro $d_name removed!${C_RESET}"
        fi
    fi
}

check_deps
while true; do
    show_banner
    echo -e " [1] Launch / Install ${C_RED}Kali Linux${C_RESET} (Red Skull Prompt)"
    echo -e " [2] Launch / Install ${C_CYAN}Parrot Security OS${C_RESET} (Cyan Prompt)"
    echo -e " [3] Launch / Install ${C_BLUE}Arch Linux${C_RESET} (Arch Prompt)"
    echo -e " [4] Launch / Install ${C_YELLOW}Ubuntu 22.04 LTS${C_RESET} (Ubuntu Prompt)"
    echo -e " [5] Launch / Install ${C_PURPLE}Debian Linux${C_RESET} (Debian Prompt)"
    echo -e " ----------------------------------------------------"
    echo -e " [6] 🔎 ${C_GREEN}Check Root Status & Environment Diagnostics${C_RESET}"
    echo -e " [7] 📦 Backup any Distro (Archive Creator)"
    echo -e " [8] 📊 Check Storage Usage (Disk Monitor)"
    echo -e " [9] 🗑️ Delete / Reset a Distro"
    echo -e " [0] Exit Master Suite"
    echo -e "${C_BLUE}------------------------------------------------------${C_RESET}"
    read -p "Select option [0-9]: " choice

    case $choice in
        1) install_kali ;;
        2) install_parrot ;;
        3) install_arch ;;
        4) install_ubuntu ;;
        5) install_debian ;;
        6) check_root_status ;;
        7) backup_distro ;;
        8) check_storage ;;
        9) remove_distro ;;
        0) echo -e "${C_RED}[*] Exiting Master Suite... Goodbye!${C_RESET}"; break ;;
        *) echo -e "${C_RED}[!] Invalid Choice! Select 0 to 9.${C_RESET}" ;;
    esac
    read -p "Press Enter to return to menu..."
done
