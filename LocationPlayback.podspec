Pod::Spec.new do |s|
  s.name             = "LocationPlayback"
  s.version          = "0.3.6"
  s.summary          = "LocationPlayback should help you with recording and playback location of your device."
  s.description      = <<-DESC
                       LocationPlayback should help you with recording and playback location of your device. We are using that lib in Bright Inventions as it helps a lot with testing the location based apps.
                       DESC
  s.homepage         = "https://github.com/bright/LocationPlayback"
  s.license          = 'MIT'
  s.author           = { "Daniel Makurat" => "daniel.makurat@gmail.com" }
  s.source           = { :git => "https://github.com/bright/LocationPlayback.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.1'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LocationPlayback' => ['Pod/Assets/*.png']
  }

  s.dependency 'PureLayout', '~> 2.0.6'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Parse', '1.8.5'
end
