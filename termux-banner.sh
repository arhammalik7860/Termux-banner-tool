#!/data/data/com.termux/files/usr/bin/bash
# =====================================================
#  TERMUX STYLISH BANNER TOOL
#  Author: Arham Farooque
#  Create your own colorful name banner in Termux
# =====================================================

set -e
BANNER_FILE="$HOME/.termux_stylish_banner"
LAST_NAME_FILE="$HOME/.termux_banner_name"
AUTHOR="Arham Farooque"

install_deps() {
  echo "[*] Installing dependencies..."
  pkg update -y
  pkg install -y figlet toilet ruby
  gem install lolcat --no-document || true
  echo "[*] All dependencies installed."
}

make_banner() {
  local name="$1"
  [ -z "$name" ] && name="ARHAM"
  toilet -f smblock "$name" | lolcat > "$BANNER_FILE"
  echo -e "\nBy: $AUTHOR" >> "$BANNER_FILE"
  echo "$name" > "$LAST_NAME_FILE"
}

enable_on_login() {
  SHELL_RC="$HOME/.bashrc"
  grep -qxF 'cat ~/.termux_stylish_banner | lolcat' "$SHELL_RC" 2>/dev/null || \
  echo 'cat ~/.termux_stylish_banner | lolcat' >> "$SHELL_RC"
  echo "[*] Banner enabled on Termux startup."
}

show_banner() {
  if [ -f "$BANNER_FILE" ]; then
    cat "$BANNER_FILE" | lolcat
  else
    echo "No banner found. Use --name to create one."
  fi
}

case "$1" in
  --install)
    install_deps
    read -p "Enter your name for the banner: " name
    make_banner "$name"
    enable_on_login
    echo "Done! Restart Termux to see your banner."
    ;;
  --name)
    make_banner "$2"
    show_banner
    ;;
  --show)
    show_banner
    ;;
  *)
    echo "Usage: ./termux-banner.sh --install | --name 'YourName' | --show"
    ;;
esac
