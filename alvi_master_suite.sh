#!/bin/bash

# Colors
R='\033[1;31m'
G='\033[1;32m'
B='\033[1;34m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
NC='\033[0m'

DISTRO_DIR="$HOME/alvi_distros"
mkdir -p "$DISTRO_DIR"

banner() {
    clear
    echo -e "${B}========================================================${NC}"
    echo -e "${Y}      🔥 ALVI ULTIMATE LINUX MASTER SUITE v3.1 🔥      ${NC}"
    echo -e "${B}========================================================${NC}"
    echo -e "${C}[+] Multi-Distro Environment & Diagnostic Central${NC}"
    echo -e "${B}========================================================${NC}"
}

check_root() {
    echo -e "\n${Y}🔍 ROOT STATUS & SYSTEM DIAGNOSTICS${NC}"
    echo -e "${B}========================================================${NC}"
    
    # Accurate Android Native Root Detection
    if [ "$(id -u)" -eq 0 ]; then
        echo -e "${W}[1] Native Android Root (su) : ${G}[FOUND / ROOTED (UID 0)]${NC}"
        EXEC_USER="Root User (UID: 0)"
    elif su -c "id" >/dev/null 2>&1; then
        echo -e "${W}[1] Native Android Root (su) : ${G}[FOUND / SU ACCESS GRANTED]${NC}"
        EXEC_USER="Standard User with SU Access"
    else
        echo -e "${W}[1] Native Android Root (su) : ${R}[NOT FOUND / NON-ROOT DEVICE]${NC}"
        EXEC_USER="Standard User (UID: $(id -u))"
    fi

    echo -e "${W}[2] Current Execution User : ${C}$EXEC_USER${NC}"
    
    if [ -d "$DISTRO_DIR" ] && [ "$(ls -A "$DISTRO_DIR" 2>/dev/null)" ]; then
        echo -e "${W}[3] PRoot Virtual Environment: ${G}[ACTIVE / INSTALLED DISTROS FOUND]${NC}"
    else
        echo -e "${W}[3] PRoot Virtual Environment: ${Y}[INACTIVE / NATIVE TERMUX]${NC}"
    fi
    echo -e "${B}========================================================${NC}"
    read -p "Press Enter to return to menu..."
}

run_or_install_distro() {
    local distro_name=$1
    local tar_url=$2
    local custom_prompt=$3
    local target_dir="$DISTRO_DIR/$distro_name"

    # Check if distro is installed, if not -> Install
    if [ ! -d "$target_dir/etc" ]; then
        echo -e "${Y}[*] $distro_name is not installed. Preparing Installation...${NC}"
        mkdir -p "$target_dir"

        if [ ! -f "$target_dir/rootfs.tar.xz" ]; then
            echo -e "${Y}[*] Downloading $distro_name RootFS (aarch64)...${NC}"
            curl -L "$tar_url" -o "$target_dir/rootfs.tar.xz"
        fi

        if [ -f "$target_dir/rootfs.tar.xz" ]; then
            echo -e "${Y}[*] Extracting RootFS (Please wait)...${NC}"
            proot --link2symlink tar -xf "$target_dir/rootfs.tar.xz" -C "$target_dir" 2>/dev/null || {
                tar -xf "$target_dir/rootfs.tar.xz" -C "$target_dir"
            }
            rm -f "$target_dir/rootfs.tar.xz"
            
            # DNS Setup for internet inside PRoot
            echo "nameserver 8.8.8.8" > "$target_dir/etc/resolv.conf" 2>/dev/null
            echo -e "${G}[+] $distro_name Installed Successfully!${NC}"
        else
            echo -e "${R}[-] Download failed! Please check your connection.${NC}"
            read -p "Press Enter to return..."
            return
        fi
    fi

    # Launching Distro Environment
    echo -e "${G}[*] Launching $distro_name Environment...${NC}"
    sleep 1
    
    # Custom Shell Prompt Injection
    PROMPT_COMMAND_STR="export PS1='$custom_prompt'; clear"

    proot -r "$target_dir" \
          -0 \
          -b /dev \
          -b /proc \
          -b /sys \
          -b /data/data/com.termux/files/home:/host-home \
          -w /root \
          /usr/bin/env -i \
          HOME=/root \
          PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
          TERM=$TERM \
          LANG=C.UTF-8 \
          /bin/bash --rcfile <(echo "$PROMPT_COMMAND_STR")
}

while true; do
    banner
    echo -e "${W}[1] Launch / Install Kali Linux (Red Skull Prompt)${NC}"
    echo -e "${W}[2] Launch / Install Parrot OS (Cyan Prompt)${NC}"
    echo -e "${W}[3] Launch / Install Arch Linux (Arch Prompt)${NC}"
    echo -e "${W}[4] Launch / Install Ubuntu 22.04 LTS (Ubuntu Prompt)${NC}"
    echo -e "${W}[5] Launch / Install Debian Linux (Debian Prompt)${NC}"
    echo -e "${B}--------------------------------------------------------${NC}"
    echo -e "${W}[6] 🔍 Check Root Status & Environment Diagnostics${NC}"
    echo -e "${W}[7] 📦 Backup any Distro (Archive Creator)${NC}"
    echo -e "${W}[8] 📊 Check Storage Usage (Disk Monitor)${NC}"
    echo -e "${W}[9] 🗑️  Delete / Reset All Distros${NC}"
    echo -e "${W}[0] 🚪 Exit Master Suite${NC}"
    echo -e "${B}========================================================${NC}"
    read -p "Select option [0-9]: " choice

    case $choice in
        1)
            run_or_install_distro "kali" \
            "https://github.com/termux/proot-distro/releases/download/v4.0.0/kali-aarch64.tar.xz" \
            "\\[\\033[1;31m\\]☠️ (Kali-RedSkull) \\[\\033[1;37m\\]\\u@\\h:\w# \\[\\033[0m\\]"
            ;;
        2)
            run_or_install_distro "parrot" \
            "https://github.com/termux/proot-distro/releases/download/v4.0.0/parrot-aarch64.tar.xz" \
            "\\[\\033[1;36m\\]🦜 (Parrot-OS) \\[\\033[1;37m\\]\\u@\\h:\w# \\[\\033[0m\\]"
            ;;
        3)
            run_or_install_distro "arch" \
            "https://github.com/termux/proot-distro/releases/download/v4.0.0/archlinux-aarch64.tar.xz" \
            "\\[\\033[1;34m\\]󰣇 (Arch-Linux) \\[\\033[1;37m\\]\\u@\\h:\w# \\[\\033[0m\\]"
            ;;
        4)
            run_or_install_distro "ubuntu" \
            "https://github.com/termux/proot-distro/releases/download/v4.0.0/ubuntu-aarch64.tar.xz" \
            "\\[\\033[1;33m\\]🍥 (Ubuntu-LTS) \\[\\033[1;37m\\]\\u@\\h:\w# \\[\\033[0m\\]"
            ;;
        5)
            run_or_install_distro "debian" \
            "https://github.com/termux/proot-distro/releases/download/v4.0.0/debian-aarch64.tar.xz" \
            "\\[\\033[1;35m\\]🌀 (Debian-Linux) \\[\\033[1;37m\\]\\u@\\h:\w# \\[\\033[0m\\]"
            ;;
        6)
            check_root
            ;;
        7)
            echo -e "${Y}[*] Current Installed Distros:${NC}"
            ls -1 "$DISTRO_DIR" 2>/dev/null
            read -p "Enter distro name to backup: " bname
            if [ -d "$DISTRO_DIR/$bname" ]; then
                echo -e "${Y}[*] Creating tar.gz backup...${NC}"
                tar -czf "$HOME/${bname}_backup.tar.gz" -C "$DISTRO_DIR" "$bname"
                echo -e "${G}[+] Backup saved to: $HOME/${bname}_backup.tar.gz${NC}"
            else
                echo -e "${R}[-] Distro not found!${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        8)
            echo -e "${C}--- Storage Monitor ---${NC}"
            du -sh "$DISTRO_DIR"/* 2>/dev/null || echo "No distros installed yet."
            read -p "Press Enter to continue..."
            ;;
        9)
            read -p "Are you sure you want to delete ALL distros? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                echo -e "${R}Cleaning up all installed distros...${NC}"
                rm -rf "${DISTRO_DIR:?}"/*
                echo -e "${G}[+] All distros cleaned successfully!${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        0)
            echo -e "${G}Exiting ALVI Linux Master Suite. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${R}Invalid option! Please choose between 0-9.${NC}"
            sleep 1
            ;;
    esac
done
