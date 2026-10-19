# 🔥 ALVI Master Suite

> A high-performance, modular, zero-dependency multi-distro Linux deployment engine and root diagnostic suite built for Termux.

[![Platform](https://img.shields.io/badge/Platform-Termux%20%2F%20Android-green.svg)](https://termux.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Alvi13759275-debug/alvi-linux-suite/pulls)

---

## 🌟 Features

* **Multi-Distro Engine:** Deploy Kali Linux, Parrot OS, Arch Linux, Ubuntu, and Debian directly without relying on `proot-distro`.
* **Authentic Shell Prompts:** Custom-built environment shells matching official distribution color schemes and prompts (e.g., Kali's red skull prompt).
* **Root Diagnostic Suite:** Real-time environment scanner for native Android `su` binary, execution user UID, PRoot virtual execution status, and SELinux policies.
* **Storage & Backup Manager:** Built-in `.tar.gz` archive backup/restore utilities and real-time disk space usage monitor.
* **Pure RootFS Extraction:** Direct deployment engine fetching official arm64 RootFS tarballs.

---

## 🚀 One-Line Quick Start

Run the following command directly in your Termux terminal to clone and run:

```bash
git clone [https://github.com/Alvi13759275-debug/alvi-linux-suite.git](https://github.com/Alvi13759275-debug/alvi-linux-suite.git) && cd alvi-linux-suite && chmod +x alvi_master_suite.sh && ./alvi_master_suite.sh
