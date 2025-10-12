# read version of Ruby from the .ruby-version file
ruby_version_path = File.join(File.dirname(__FILE__), '.ruby-version')
ruby File.read(ruby_version_path).strip

source "https://rubygems.org"

gem 'danger', '~> 9.3'
gem 'danger-swiftlint', '~> 0.34.0'
gem 'danger-swiftformat', '~> 0.9.0'
gem 'danger-xcode_summary', '~> 1.3.1'
gem 'fastlane', '~> 2.227.0'
gem 'xcode-install', '~> 2.8'
gem 'xcresult', '~> 0.2.2'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
