Pod::Spec.new do |s|
  s.name              = "JOSESwiftDynamic"
  s.version           = "2.2.1"
  s.license           = "Apache License, Version 2.0"

  s.summary           = "JOSE framework for Swift"
  s.authors           = { "Airside Mobile, Inc. an Entrust Company" => "joseswift@airsidemobile.com" }
  s.homepage          = "https://github.com/airsidemobile/JOSESwift"
  s.documentation_url = "https://github.com/airsidemobile/JOSESwift/wiki"

  s.swift_version     = "5.0"
 

  s.user_target_xcconfig = {
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
    'VALID_ARCHS' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64'
  }

  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64',
    'VALID_ARCHS' => 'arm64'
  }

  s.dependency 'JOSESwift', '2.2.1'
  s.source            = { :path => 'Dependencies/JOSESwiftDynamic' }

end