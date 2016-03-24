Pod::Spec.new do |s|
  s.name             = 'GuttlerPageControl'
  s.version          = '0.1.0'
  s.summary          = 'A cute page control in Swift'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/atuooo/GuttlerPageControl'

  s.authors          = { "oOatuo" => "aaatuooo@gmail.com" }
  s.social_media_url = "https://twitter.com/OoAtuo"

  s.ios.deployment_target = "8.0"

  s.source           = { :git => 'https://github.com/atuooo/GuttlerPageControl.git', :tag => s.version.to_s }
  s.source_files     = 'GuttlerPageControl/*.swift', 'GuttlerPageControl/RandomColor/*.swift'
  s.requires_arc     = true
end