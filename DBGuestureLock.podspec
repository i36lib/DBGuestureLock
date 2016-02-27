Pod::Spec.new do |s|
  s.name         = "DBGuestureLock"
  s.version      = "0.0.1"
  s.summary      = "An iOS Guesture Lock View"
  s.description  = <<-DESC
                  DBGuestureLock is an iOS drop-in class for adding a guesture lock to your app. It is easy to use and can be config for guesture lock colors.
                   DESC
  s.homepage     = "http://i36.Me/"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "i36.Me" => "i36.lib@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/i36lib/DBGuestureLock.git", :tag => s.version.to_s }
  s.source_files  = "*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
