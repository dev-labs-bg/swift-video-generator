Pod::Spec.new do |s|
  s.name             = 'SwiftVideoGenerator'
  s.version          = '0.1.0'
  s.summary          = 'Easy way to combine images and audio into a video or merge multiple videos into one'
  s.homepage         = 'https://github.com/dev-labs-bg/SwiftVideoGenerator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dev Labs BG' => 'http://devlabs.bg/' }
  s.source           = { :git => 'https://github.com/dev-labs-bg/SwiftVideoGenerator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/devlabsbg'
  s.ios.deployment_target = '8.0'
  s.source_files = 'SwiftVideoGenerator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftVideoGenerator' => ['SwiftVideoGenerator/Assets/*.png']
  # }
end
