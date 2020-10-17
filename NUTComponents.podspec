#
# Be sure to run `pod lib lint NUTComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NUTComponents'
  s.version          = '0.1.0'
  s.summary          = 'Un Framework para componentes custom'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        Un Framework donde se pueden agregar extensiones, clases custom y componentes para hacer mas rapido el desarrollo.
                       DESC

  s.homepage         = 'https://github.com/migue19/NUTComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'migue19' => 'miguelmexicano18@gmail.com' }
  s.source           = { :git => 'https://github.com/migue19/NUTComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.1'

  s.source_files = 'NUTComponents/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NUTComponents' => ['NUTComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
