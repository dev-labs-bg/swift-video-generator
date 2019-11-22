Pod::Spec.new do |s|
  s.name             = 'SwiftVideoGenerator'
  s.version          = '1.4.0'
  s.summary          = 'Easy way to combine images and audio into a video or merge multiple videos into one'
  s.homepage         = 'https://github.com/dev-labs-bg/swift-video-generator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dev Labs BG' => 'http://devlabs.bg/' }
  s.source           = { :git => 'https://github.com/dev-labs-bg/swift-video-generator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/devlabsbg'
  s.swift_version    = '4.2'
  s.ios.deployment_target = '10.0'
  s.source_files     = 'Sources/**/*'
end
