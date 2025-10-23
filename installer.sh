#!/usr/bin/env bash
CYAN="\033[1;36m"
GREEN="\033[1;32m"
MAGENTA="\033[1;35m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"
BOLD="\033[1m"

print_banner() {
    clear
    local cols=$(tput cols)
    local line="DRAGON_TUNNEL INSTALLER"
    local border=$(printf '%*s' "$cols" '' | tr ' ' '_')
    echo -e "${MAGENTA}${border}${RESET}"
    local padding=$(( (cols - ${#line}) / 2 ))
    echo -e "${CYAN}${BOLD}$(printf '%*s' $padding '')${line}${RESET}"
    echo -e "${MAGENTA}${border}${RESET}"
    echo
}

install_animation() {
    local msg=$1
    echo -ne "${CYAN}${msg} "
    for i in {1..10}; do
        echo -n "."
        sleep 0.2
    done
    echo -e "${RESET}"
}

check_install_wg() {
    if ! command -v wg-quick &> /dev/null; then
        echo -e "${YELLOW}[!] wireguard-tools not found.${RESET}"
        install_animation "Installing wireguard-tools"
        
        if command -v apt &> /dev/null; then
            sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq &> /dev/null
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq wireguard-tools &> /dev/null
        elif command -v yum &> /dev/null; then
            sudo yum install -y -q wireguard-tools &> /dev/null
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy --noconfirm wireguard-tools &> /dev/null
        else
            echo -e "${RED}[!] Could not detect package manager. Please install wireguard-tools manually.${RESET}"
            exit 1
        fi

        echo -e "${GREEN}[✔] wireguard-tools installed successfully!${RESET}"
    fi
}

print_banner
check_install_wg

if [[ $EUID -ne 0 ]]; then
    echo -e "${YELLOW}[⚠] You need root privileges to install globally.${RESET}"
    echo -e "${CYAN}Try: sudo bash installer.sh${RESET}"
    exit 1
fi

BIN_DIRS=("/usr/local/bin" "/usr/local/sbin")
SCRIPTS=("dragontunnel" "stop")

for script in "${SCRIPTS[@]}"; do
    SRC_PATH="src/$script"
    if [ ! -f "$SRC_PATH" ]; then
        echo -e "${RED}[✖] $script not found in src/ folder!${RESET}"
        continue
    fi

    for dir in "${BIN_DIRS[@]}"; do
        install_animation "Installing $script to $dir"
        cp "$SRC_PATH" "$dir/"
        chmod +x "$dir/$script"
        echo -e "${GREEN}[✔] $script installed to $dir and made executable.${RESET}"
    done
done

echo
echo -e "${BOLD}${MAGENTA}Installation complete! You can now run:${RESET}"
echo -e "${CYAN}dragontunnel${RESET}  - To start the tunnel"
echo -e "${CYAN}stop${RESET}    - To stop the tunnel"
echo

