Pod::Spec.new do |s|
  s.name         = "Checkout3DS-Security"
  s.version      = "3.2.3"
  s.summary      = "Checkout 3DS SDK Security"
  s.homepage     = "https://checkout.github.io/checkout-mobile-docs/checkout-3ds-sdk-ios/index.html"

  s.swift_version = "5.0"
  s.license      = <<-DESC
                        Copyright (c) 2021 Checkout.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use the Software solely for the purposes of integrating the operation of the Software with the operation of other software or systems used by the person to whom the Software is furnished.

Except as expressly provided in the foregoing paragraph, the person to whom the Software is furnished has no right (and shall not permit any third party) to copy, distribute, re-distribute, sub-license, adapt, reverse engineer, decompile, disassemble, modify or make error corrections to the Software in whole or in part.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                   DESC
  s.author       = { "Checkout.com Integration" => "integration@checkout.com" }
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/checkout/checkout-3ds-sdk-ios.git", :tag => s.version }

  s.vendored_frameworks = "Checkout3DS-Security.xcframework"

  s.user_target_xcconfig = {
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
    'VALID_ARCHS' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64'
  }

  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64',
    'VALID_ARCHS' => 'arm64'
  }
end
