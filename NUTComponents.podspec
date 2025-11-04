#
# Be sure to run `pod lib lint NUTComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NUTComponents'
  s.version          = '0.1.3'
  s.summary          = 'Un Framework para componentes custom'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        Un Framework con componentes UI.
                       DESC

  s.homepage         = 'https://github.com/migue19/NUTComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Miguel Mexicano Herrera' => 'miguelmexicano18@gmail.com' }
  s.source           = { :git => 'https://github.com/migue19/NUTComponents.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.0'

  s.source_files = 'Classes/**/*'
  s.swift_version = "5.0"
  
  # s.resource_bundles = {
  #   'NUTComponents' => ['NUTComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
