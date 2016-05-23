Pod::Spec.new do |s|
  s.name         = "UIWheelGestureRecognizer"
  s.version      = "0.0.1"
  s.summary      = "Subclass of UIGestureRecognizer for wheel touch."
  s.license      = "MIT"
  s.author       = { "Song Chiwon" => "iamchiwon@gmail.com" }
  s.homepage     = "https://github.com/iamchiwon/UIWheelGestureRecognizer"
  s.source       = { :git => "https://github.com/iamchiwon/UIWheelGestureRecognizer.git", :tag => "0.0.1" }
  s.source_files = "Classes/**/*.{swift}"
  s.requires_arc = true
end
