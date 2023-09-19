#!/usr/bin/env bash

# Tools versions #

swiftlint_version="0.42.0"

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

tap_ios() {
    brew update
    brew tap ssuhanov/tap-ios git@github.com:ssuhanov/homebrew-tap-ios.git
}

tap_swiftlint() {
    tap_ios
    brew install ssuhanov/homebrew-tap-ios/swiftlint@${swiftlint_version}
    brew reinstall swiftlint@${swiftlint_version} || brew link --overwrite swiftlint@${swiftlint_version}
    echo "Check Swiftlint version..."
    swiftlint version
}

install_swiftlint() {
    if ! which swiftlint >& /dev/null; then
        echo "Swiftlint is not installed. Installing Swiftlint..."
        if which brew >& /dev/null; then
            tap_swiftlint
        else
            echo "Failed to install Swiftlint. Please install manually ❌"
            exit 1
        fi
    else
        if ! swiftlint version | grep -q $swiftlint_version; then
            echo "Invalid Swiftlint version. ${swiftlint_version} expected. Reinstalling Swiftlint..."
            brew uninstall --force swiftlint
            tap_swiftlint
        else
            echo "Found ${swiftlint_version} version of Swiftlint ✅"
        fi
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
# Check for flags and shortcuts
for i in "$@"
do
case $i in
    "") ;;
    install_homebrew) "$@"; exit;;
    install_swiftlint) "$@"; exit;;
esac
done

echo "Looking for Bundler..."
install_bundler

echo "Looking for Homebrew..."
install_homebrew

echo "Looking for Swiftlint..."
install_swiftlint

echo "💎 Installing Gems..."
bundle install

echo "🛠 Checking Xcode version..."
check_xcode

echo "ALL DONE! ✅"
