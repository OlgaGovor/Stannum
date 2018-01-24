
Pod::Spec.new do |s|

#1
s.platform     = :ios
s.ios.deployment_target = '9.0'
s.name         = "Stannum"
s.summary      = "UI Test Automation helper in Swift"
s.requires_arc = true

#2
s.version      = '0.0.1'

#3
s.license      = { :type => "MIT", :file => "LICENSE" }

#4
s.author       = { "Olga Govor" => "olga.govor.ua@gmail.com" }

#5
s.homepage     = "http://qa42.ru"

#6
s.source       = { :git => "https://github.com/OlgaGovor/Stannum.git", :tag => "#{s.version}" }

#7
s.framework = 'XCTest'
#s.dependency 'Alamofire'

#8
s.source_files  = "Stannum/**/*.{swift}"

end


