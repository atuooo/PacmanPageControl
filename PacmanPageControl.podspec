Pod::Spec.new do |s|
  s.name             = "PacmanPageControl"
  s.version          = "0.3.2"
  s.summary          = <<-DESC
                       Let's play Pac-Man.
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = "https://github.com/atuooo/PacmanPageControl"

  s.authors          = { "oOatuo" => "aaatuooo@gmail.com" }
  s.social_media_url = "https://twitter.com/OoAtuo"

  s.swift_version    = "4.0"
  s.ios.deployment_target = "8.0"

  s.source           = { 
                        :git => "https://github.com/atuooo/PacmanPageControl.git", 
                        :tag => s.version
                       }
  # s.dependency 'RandomColorSwift'

  s.source_files        = "PacmanPageControl/*.swift"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.requires_arc        = true
end
