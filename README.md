<p align="center">
  <h1 align="center">🔥 ALVI LINUX MASTER SUITE 🔥</h1>
</p>

<p align="center">
  <b>The Ultimate Multi-Distro Environment Deployer & Diagnostic Suite for Termux</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-brightgreen">
  <img src="https://img.shields.io/badge/Platform-Termux%20%2F%20Linux-blue">
  <img src="https://img.shields.io/badge/License-MIT-orange">
  <img src="https://img.shields.io/badge/Author-Alvi-red">
</p>

---

## 🚀 About The Project
**Alvi Linux Master Suite** is a powerful, lightweight, and independent multi-distro deployment engine designed specifically for Termux. It allows users to run genuine Linux distributions (Kali, Parrot, Arch, Ubuntu, Debian) inside their Android device **without needing PRoot-Distro package dependency**, complete with native shell prompts, backup systems, and root diagnostics!

---

## 🌟 Key Features
* 🐧 **Multi-Distro Support:** Deploy Kali Linux, Parrot OS, Arch Linux, Ubuntu, and Debian seamlessly.
* 💀 **Authentic Shell Prompts:** Experience custom color-coded and original environment prompts (e.g., Kali red skull prompt).
* 🔍 **Root Diagnostic Suite:** Check native Android `su` binary, execution user UID, and active virtual environments.
* 📦 **Built-in Backup & Restore:** Create compressed `.tar.gz` archives of your customized distros instantly.
* 📊 **Storage & Disk Monitor:** Track exact disk space usage of each deployed operating system.
* 🗑️ **Smart Cleaner:** Easily remove or reset distros to free up phone storage.

---

## ⚙️ Quick Installation

Run the following commands in your Termux terminal to install and launch:

```bash
# 1. Update packages and install git/wget
pkg update && pkg install git wget -y

# 2. Clone the repository
git clone [https://github.com/YOUR_USERNAME/alvi-linux-suite.git](https://github.com/YOUR_USERNAME/alvi-linux-suite.git)

# 3. Enter directory and give permissions
cd alvi-linux-suite
chmod +x alvi_master_suite.sh

# 4. Run the master suite
./alvi_master_suite.sh
