# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

use_frameworks!

target 'Game Cat' do
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
end

target 'Game CatTests' do
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
end

# RxSwift Stuff
deployment_target = '15.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
