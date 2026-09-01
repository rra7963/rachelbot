#!/usr/bin/env bash
#
# RachelBot Installation Script
# Usage: curl -fsSL https://rachelbot.com/install.sh | bash
#

set -e

RACHELBOT_VERSION="${RACHELBOT_VERSION:-latest}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.rachelbot}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
  echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Linux*)  OS=linux;;
    Darwin*) OS=darwin;;
    MINGW*|MSYS*|CYGWIN*) OS=windows;;
    *) error "Unsupported operating system";;
  esac
}

# Detect architecture
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64) ARCH=amd64;;
    arm64|aarch64) ARCH=arm64;;
    *) error "Unsupported architecture: $(uname -m)";;
  esac
}

# Check dependencies
check_deps() {
  info "Checking dependencies..."

  if ! command -v node &> /dev/null; then
    error "Node.js is required. Install from https://nodejs.org/"
  fi

  NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
  if [ "$NODE_VERSION" -lt 18 ]; then
    error "Node.js 18+ is required. Current version: $(node -v)"
  fi

  success "Node.js $(node -v)"
}

# Create directories
create_dirs() {
  info "Creating directories..."
  mkdir -p "$INSTALL_DIR"
  mkdir -p "$BIN_DIR"
  success "Created $INSTALL_DIR"
}

# Install RachelBot
install_rachelbot() {
  info "Installing RachelBot..."

  cd "$INSTALL_DIR"

  if [ "$RACHELBOT_VERSION" = "latest" ]; then
    npm init -y > /dev/null 2>&1 || true
    npm install rachelbot@latest
  else
    npm init -y > /dev/null 2>&1 || true
    npm install "rachelbot@$RACHELBOT_VERSION"
  fi

  # Create symlink
  ln -sf "$INSTALL_DIR/node_modules/.bin/rachelbot" "$BIN_DIR/rachelbot"

  success "Installed RachelBot"
}

# Add to PATH
setup_path() {
  info "Setting up PATH..."

  SHELL_RC=""
  case "$SHELL" in
    */zsh) SHELL_RC="$HOME/.zshrc";;
    */bash) SHELL_RC="$HOME/.bashrc";;
    *) SHELL_RC="$HOME/.profile";;
  esac

  if [ -f "$SHELL_RC" ]; then
    if ! grep -q "$BIN_DIR" "$SHELL_RC"; then
      echo "" >> "$SHELL_RC"
      echo "# RachelBot" >> "$SHELL_RC"
      echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
      success "Added $BIN_DIR to PATH in $SHELL_RC"
    fi
  fi
}

# Print success message
print_success() {
  echo ""
  echo -e "${GREEN}========================================${NC}"
  echo -e "${GREEN}  RachelBot installed successfully! 🎉${NC}"
  echo -e "${GREEN}========================================${NC}"
  echo ""
  echo "To get started:"
  echo ""
  echo "  1. Start a new shell or run:"
  echo "     source $SHELL_RC"
  echo ""
  echo "  2. Run the setup wizard:"
  echo "     rachelbot onboard"
  echo ""
  echo "  3. Start RachelBot:"
  echo "     rachelbot start"
  echo ""
  echo "Documentation: https://rachelbot.com/docs"
  echo "Discord: https://discord.gg/rachelbot"
  echo ""
}

# Main
main() {
  echo ""
  echo -e "${BLUE}RachelBot Installer${NC}"
  echo "================"
  echo ""

  detect_os
  detect_arch
  check_deps
  create_dirs
  install_rachelbot
  setup_path
  print_success
}

main "$@"
