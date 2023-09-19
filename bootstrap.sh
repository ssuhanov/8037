#!/usr/bin/env bash

# Helpers #

install_bundler() {
    if ! which bundler >& /dev/null || ! bundler --version >& /dev/null; then
        echo "Bundler is not installed. Installing Bundler..."
        gem install bundler
    else
        echo "Bundler Installed ✅"
    fi
}

# Implementation #

echo "Looking for Bundler..."
install_bundler

echo "💎 Installing Gems..."
bundle install
