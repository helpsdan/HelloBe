# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'HelloBe' do
    
    pod 'BMSCore'

      # Comment this line if you're not using Swift and don't want to use dynamic frameworks

      use_frameworks!

      pod 'BMSCore'
      pod 'MessageKit'
      pod 'NVActivityIndicatorView'
      pod 'Firebase/Core'


    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if ['SwiftCloudant'].include? target.name
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '3.2'
                end
            end
        end
    end
    # Pods for HelloBe
    target 'HelloBeTests' do
        inherit! :search_paths
        # Pods for testing
    end

    target 'HelloBeUITests' do
        inherit! :search_paths
        # Pods for testing
    end

end
