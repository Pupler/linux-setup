# shellcheck shell=bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'
LOG_FILE='setup.log'

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "${LOG_FILE}"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SUCCESS] $1" >> "${LOG_FILE}"
}

print_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1" >> "${LOG_FILE}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARNING] $1" >> "${LOG_FILE}"
}