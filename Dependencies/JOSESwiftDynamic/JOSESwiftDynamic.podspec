Pod::Spec.new do |s|
  s.name              = "JOSESwiftDynamic"
  s.version           = "2.2.1"
  s.license           = "Apache License, Version 2.0"

  s.summary           = "JOSE framework for Swift"
  s.authors           = { "Airside Mobile, Inc. an Entrust Company" => "joseswift@airsidemobile.com" }
  s.homepage          = "https://github.com/airsidemobile/JOSESwift"
  s.documentation_url = "https://github.com/airsidemobile/JOSESwift/wiki"

  s.swift_version     = "5.0"
  s.source_files      = 'Sources/JOSESwiftDynamic/*.swift'
  s.source            = { :git => 'https://github.com/checkout/checkout-3ds-sdk-ios.git', :tag => s.version.to_s }

  s.dependency 'JOSESwift', '2.2.1'
end
