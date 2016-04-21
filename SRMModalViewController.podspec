Pod::Spec.new do |s|

  s.name         = "SRMModalViewController"
  s.version      = "0.0.2"
  s.summary      = "SRMModalViewController support a easy way to display a view with modal style."
  s.description  = "SRMModalViewController support a easy way to display a view with modal style.You will love it."
  s.homepage     = "https://github.com/SongRanMark/SRMModalViewController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "SongRanMark"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/SongRanMark/SRMModalViewController.git", :tag => "v#{s.version}" }
  s.source_files  = "*.{h,m}"
  s.exclude_files = "Example"
  s.requires_arc = true

end
