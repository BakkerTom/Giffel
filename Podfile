# Uncomment the next line to define a global platform for your project
# platform :ios, ’9.0’

target 'Giffel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Giffel
  pod 'Alamofire', '~> 4.0.1'
  pod 'Nuke', '~> 4.1.1'
  pod 'Nuke-FLAnimatedImage-Plugin'

  target 'GiffelTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
