source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
# use_frameworks!

workspace 'Scheduler.xcworkspace'

def import_common
	pod 'libextobjc'
end

target 'Scheduler' do
	import_common
	pod 'ReactiveCocoa', '~> 2.5'
	pod 'Crashlytics'
	pod 'Fabric'
	pod 'Masonry'
	xcodeproj 'Scheduler.xcodeproj'
end

target 'SchedulerTests' do
	import_common
	pod 'Kiwi'
	xcodeproj 'Scheduler.xcodeproj'
end
