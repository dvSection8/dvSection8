#
# Be sure to run `pod lib lint dvSection8.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'dvSection8'
s.version          = '1.0.0'
s.summary          = 'dvSection8 is a boilerplate framework for the ios developer. This will be the reference for using a standard codes to everyone.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
dvSection8 is a boilerplate framework for the ios developer. This will be the reference for using a standard codes to everyone. This is also help to easily develop the app.
DESC

s.homepage         = 'https://github.com/dvSection8/dvSection8.git'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'dvSection8' => 'section8.rush@gmail.com' }
s.source           = { :git => 'https://github.com/dvSection8/dvSection8.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '9.0'

s.source_files = 'dvSection8/Classes/**/*'

# s.resource_bundles = {
#   'dvSection8' => ['dvSection8/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
s.dependency 'JSONCodable', '~> 3.0.1'
s.dependency 'AsyncSwift'
s.dependency 'SDWebImage', '~> 4.0'
s.dependency 'FBSDKCoreKit'
s.dependency 'FBSDKLoginKit'
s.dependency 'FBSDKShareKit'
s.dependency 'IQKeyboardManager'
s.dependency 'ReachabilitySwift', '~> 3'
s.dependency 'HTTPStatusCodes', '~> 3.1.2'
end
