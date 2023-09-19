# read version of Ruby from the .ruby-version file
ruby_version_path = File.join(File.dirname(__FILE__), '.ruby-version')
ruby File.read(ruby_version_path).strip

source "https://rubygems.org"

gem 'fastlane', '~> 2.215'
gem 'xcode-install', '~> 2.8'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
