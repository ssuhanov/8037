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

install_homebrew() {
    if [[ $(command -v brew) == "" ]]; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL  https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Homebrew Installed ✅"
    fi
}

check_xcode() {
    project_version=$(head -n 1 .xcode-version)
    installed_versions=($(bundle exec xcversion installed))
    selected_version=$(bundle exec xcversion selected | grep -E "Xcode \d.*" | sed "s/Xcode //")
    if [[ "$selected_version" == "$project_version" ]]; then
        echo "Using Xcode ${project_version} ✅"
    else
        echo "Xcode ${project_version} is not installed ❌"
    fi
}

# Implementation #

echo "Looking for Bundler..."
install_bundler

echo "Looking for Homebrew..."
install_homebrew

echo "💎 Installing Gems..."
bundle install

echo "🛠 Checking Xcode version..."
check_xcode

echo "ALL DONE! ✅"
