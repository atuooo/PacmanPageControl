Pod::Spec.new do |s|
  s.name             = 'PacmanPageControl'
  s.version          = '0.2.0'
  s.summary          = 'Let's play Pac-Man'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/atuooo/PacmanPageControl'

  s.authors          = { "oOatuo" => "aaatuooo@gmail.com" }
  s.social_media_url = "https://twitter.com/OoAtuo"

  s.ios.deployment_target = "8.0"

  s.source           = { :git => 'https://github.com/atuooo/PacmanPageControl.git', :tag => s.version }
  s.source_files     = 'Sources/*.swift'
  s.requires_arc     = true
end