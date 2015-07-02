Pod::Spec.new do |s|
  s.name         = "ApptlyPod"
  s.version      = "0.0.6"
  s.summary      = "Apptly core code"
  s.homepage     = "https://github.com/richmondwatkins/PodTest"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "richmondwatkins" => "richmondwatkins@mac.com" }
  s.source       = { :git => "https://github.com/richmondwatkins/ApptlyPod.git", :tag => '0.0.6' }
  s.platform     = :ios, '7'
  s.source_files = 'ApptlyPod/**/*.{h,m}'
  s.exclude_files = 'ApptlyPod/main.m'
  s.resources     = 'ApptlyPod/ApptlyPod.xcdatamodeld', 'ApptlyPod/DataSeedFiles/**/*'
  s.frameworks    = 'Pinterest', 'Fabric', 'TwitterKit', 'Crashlytics', 'GoogleOpenSource', 'GooglePlus', 'TwitterCore', 'CoreData', 'Security', 'AssetsLibrary', 'Foundation', 'CoreLocation', 'CoreGraphics', 'CoreText', 'MediaPlayer', 'SystemConfiguration', 'CoreVideo', 'CoreMotion', 'AddressBook', 'AddressBookUI'
  s.requires_arc = true
  s.dependency 'AFNetworking'
  s.dependency 'MMDrawerController', '~> 0.5.7'
  s.dependency 'AWSSNS', '~> 2.1.2'
  s.dependency 'Bolts'
end