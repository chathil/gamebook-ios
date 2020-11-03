platform :ios, '13.0'
use_frameworks!
  
target 'gamebook' do
  pod 'SwiftLint'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
            config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
        end
    end
 end
