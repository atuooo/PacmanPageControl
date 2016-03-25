Pod::Spec.new do |s|
  s.name             = 'GuttlerPageControl'
  s.version          = '0.1.1'
  s.summary          = 'A cute PageControl in Swift'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/atuooo/GuttlerPageControl'

  s.authors          = { "oOatuo" => "aaatuooo@gmail.com" }
  s.social_media_url = "https://twitter.com/OoAtuo"

  s.ios.deployment_target = "8.0"

  s.source           = { :git => 'https://github.com/atuooo/GuttlerPageControl.git', :tag => s.version.to_s, :commit => a82ecbd37d5798f6721f2f6629a049ab37a0257b }
  s.source_files     = 'Classes/*.swift'
  s.requires_arc     = true
end