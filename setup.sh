#!/bin/bash

# This script setups linux after fresh install

GREEN='\033[0;32m'
RESET='\033[0m'

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
}

print_status "Hi! The script started."