Pod::Spec.new do |s|
  s.name = "RBBAnimation"
  s.version = "0.0.1"
  s.summary = "Block-based animations made easy."

  s.homepage = "https://github.com/robb/RBBAnimation"
  s.license = 'All Rights Reserved'

  s.author = { "Robert Böhnke" => "robb@robb.is" }

  s.ios.deployment_target = '7.0'

  s.source = { :git => "https://github.com/robb/RBBAnimation.git", :tag => "0.0.1" }

  s.source_files = 'RBBAnimation', 'RBBAnimation/**/*.{h,m}'

  s.framework = 'QuartzCore'
  s.requires_arc = true
end
