# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

pod 'RSDayFlow'
pod "RATreeView", "~> 2.0.1"
pod 'MBProgressHUD', '~> 0.9.1'
pod "RFMarkdownTextView", "~> 1.4"
pod 'RedditKit', :git => 'https://github.com/samsymons/RedditKit.git', :branch => '2.0-beta1'



post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-acknowledgements.plist', 'Settings.bundle/Pods-acknowledgements.plist', :remove_destination => true)
end
