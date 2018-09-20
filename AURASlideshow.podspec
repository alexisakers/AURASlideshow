Pod::Spec.new do |s|
s.name         = "AURASlideshow"
s.version      = "1.0.0"
s.summary      = "Simple slideshow for in-app tutorials"
s.description  = <<-DESC
AURASlideshow provides an interface to display a sequence of images and associated text. Ideal for a tutorial inside an app. Suports swiping and Voice Over.
DESC
s.homepage     = "https://github.com/alexaubry/AURASlideshow"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Alexis Aubry" => "me@alexaubry.fr" }
s.social_media_url   = "https://twitter.com/_alexaubry"
s.ios.deployment_target = "10.0"
s.source       = { :git => "https://github.com/alexaubry/AURASlideshow.git", :tag => s.version.to_s }
s.source_files  = "Sources/**/*.swift"
s.frameworks  = "UIKit"
s.module_name = "AURASlideshow"
s.swift_version = "4.2"
end