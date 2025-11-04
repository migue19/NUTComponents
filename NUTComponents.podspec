Pod::Spec.new do |s|
  s.name             = 'NUTComponents'
  s.version          = '1.0.3'
  s.summary          = 'A comprehensive collection of reusable UI components and keyboard extensions for iOS applications.'
  
  s.description      = <<-DESC
  NUTComponents is a powerful UI component library that provides:
  - Custom UI components including buttons, text fields, cards, and progress views
  - Keyboard management extensions for UIViewController, UITextField, UITextView, and UISearchBar
  - Material Design inspired button with elevation and ripple effects
  - Ready-to-use components for training sessions and data visualization
  - Fully customizable and IBDesignable components
                       DESC

  s.homepage         = 'https://github.com/migue19/NUTComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Miguel Mexicano Herrera' => 'miguelmexicano18@gmail.com' }
  s.source           = { :git => 'https://github.com/migue19/NUTComponents.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8', '5.9']

  s.source_files = 'Classes/**/*.swift'
  
  # Organize subspecs for better modularity
  s.subspec 'Keyboard' do |keyboard|
    keyboard.source_files = 'Classes/NUTKeyboard*.swift'
  end
  
  s.subspec 'Buttons' do |buttons|
    buttons.source_files = 'Classes/NUTMaterialButton.swift', 'Classes/ComponentsUI/Buttons/*.swift'
  end
  
  s.subspec 'Card' do |card|
    card.source_files = 'Classes/Card/*.swift'
  end
  
  s.subspec 'ComponentsUI' do |components|
    components.source_files = 'Classes/ComponentsUI/*.swift'
  end

  s.frameworks = 'UIKit', 'Foundation'
  
  # Resource bundles if you have assets
  # s.resource_bundles = {
  #   'NUTComponents' => ['NUTComponents/Assets/*.png']
  # }

  # Platform specific configurations
  s.ios.frameworks = 'UIKit'
  
  # Build settings
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '5.0',
    'DEFINES_MODULE' => 'YES'
  }

end
