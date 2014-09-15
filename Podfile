platform :ios, '7.0'
inhibit_all_warnings!
xcodeproj 'Socialize.xcodeproj'

link_with 'Socialize'
pod 'Loopy', '~> 1.0.0'
pod 'Facebook-iOS-SDK', '~> 3.17'
pod 'SZOAuthConsumer', :podspec => 'https://raw.github.com/socialize/OAuthConsumer/master/SZOAuthConsumer.podspec'
pod 'SZJSONKit', :podspec => 'https://raw.github.com/socialize/JSONKit/master/SZJSONKit.podspec'
pod 'SZBlocksKit', :podspec => 'https://raw.github.com/socialize/BlocksKit/master/SZBlocksKit.podspec'
#Need to use this podspec and post_install Pods.xcconfig script below as eliminate libffi issues
#per https://github.com/pandamonia/BlocksKit/issues/178
pod 'Pinterest-iOS', '~> 2.3'
pod 'STTwitter', '~> 0.1.4'

target 'UIIntegrationAcceptanceTests', :exclusive => true do
  pod 'KIF', '~> 2.0'
end

post_install do | installer |
  #copy resources from Loopy to include in framework
  require 'fileutils'
  FileUtils.cp_r(Dir['Pods/Loopy/Loopy/Resources/*'], 'Socialize/Resources', :remove_destination => true)
  FileUtils.cp_r('Pods/Loopy/Loopy/LoopyApiInfo.plist', 'Socialize/Resources', :remove_destination => true)

  #per https://github.com/CocoaPods/CocoaPods/issues/1761
  #NO LONGER NEEDED 2/13/14: done in forked repo podspecs
  #workDir = Dir.pwd
  #xcconfigFilename = "#{workDir}/Pods/Pods.xcconfig"
  #xcconfig = File.read(xcconfigFilename)
  #newXcconfig = xcconfig.gsub(/-Wl,-no_compact_unwind /, "")
  #newXcconfig = newXcconfig.concat("\nWARNING_LDFLAGS = -Wl,-no_compact_unwind")
  #File.open(xcconfigFilename, "w") { |file| file << newXcconfig }

  #per http://stackoverflow.com/questions/19875166/ios-7-isa-is-deprecated
  installer.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DIRECT_OBJC_ISA_USAGE'] = 'NO'
    end
  end
end
