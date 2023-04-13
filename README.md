# iOS 3D Secure SDK from Checkout.com

The Checkout.com 3D Secure (3DS) mobile SDK allows you to provide a native 3DS2 experience in your mobile app, with visual styling that you can control. 

The SDK handles the device data collection, communication with the card issuer, and presentation of 3D Secure challenges to the customer when required. 

👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://www.checkout.com/docs/risk-management/3d-secure/sessions/non-hosted-sessions/3d-secure-mobile-sdks)

📚&nbsp;&nbsp;[Read the reference documentation](https://checkout.github.io/checkout-mobile-docs/checkout-3ds-sdk-ios/index.html)
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

## Features
1. Supports **3D Secure protocols 2.1.0 and 2.2.0.**
2. Presents **native 3DS2 challenge screens to the user, with styling that you can customise** to best fit your apps and branding.
3. Optionally **falls back to 3DS1** when 3DS2 is not available, returning the same authentication result to your app as for 3DS2. (This option can be configured by Checkout.com for your account.)
4. Supports a **range of local languages and accessibility needs**, and allows you to set your own string translations.
5. Meets requirements from **EMVCo and the PCI Security Standards Council**, specifically set for 3DS SDKs, so you can be sure it is interoperable with card issuers and that your customers’ sensitive data stays secure.

## Minimum Requirements
The 3DS SDK for iOS requires Xcode 13.1 and above with Swift version 5.6.2 and above, and supports apps targeting iOS 12.0 and above. It also supports Objective-C. There are two ways to integrate our 3DS SDK.

## Getting Started

First, integrate the 3DS SDK into your app.

### Integrating with CocoaPods
[CocoaPods](http://cocoapods.org) is the traditional dependency manager for Apple projects. We still support it, but we're not always able to validate all its peculiar ways.

Make sure cocoapods is installed on your machine by running
```bash
$ pod --version
```
Any version newer than **1.10.0** is a good sign. If not installed, or unsupported, follow [Cocoapods Getting Started](https://guides.cocoapods.org/using/getting-started.html)

Once Cocoapods of a valid version is on your machine, to integrate Frames into your Xcode project, update your `Podfile`:
```ruby
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'CheckoutEventLoggerKit', '1.2.3'
  pod 'Checkout3DS', :git => 'git@github.com:checkout/checkout-3ds-sdk-ios.git', :tag => '3.0.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

```

Then, run the following command in terminal:

```bash
$ pod install
```
Note: your Pod setup may have the following [issue](https://github.com/checkout/checkout-3ds-sdk-ios/issues/4)

To update your existing Cocoapod dependencies, use:
```bash
$ pod update
```


Then, configure your app to:

### Integrating with Checkout 3DS servers
This integration method involves one call to our `authenticate` method, which will perform an entire Authentication flow using Checkout.com's 3DS servers.

1. Initialize the SDK with your preferred user interface options using our `uiCustomization` object.
2. Configure the parameters for an authentication.
3. Request authentication and handle the result to continue your payment flow.

#### Code snippet

```swift
// 1. Init with defaults
let checkout3DS = Checkout3DSService()

// 2. Init with explicit arguments
let checkout3DS = Checkout3DSService(
    environment: .production,
    locale: Locale(identifier: "en_GB"),
    uiCustomization: uiCustomization,
    appURL: URL(string: "myapp://my-app-url")!
)

let authenticationParameters = AuthenticationParameters(
    sessionID: sessionID,
    sessionSecret: sessionSecret,
    scheme: scheme)

checkout3DS.authenticate(authenticationParameters: authenticationParameters) { error in
    if let error = error {
        // Handle error.
    } else {
        // Continue with payment.
    }
}
```
👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://www.checkout.com/docs/risk-management/3d-secure/sessions/non-hosted-sessions/3d-secure-mobile-sdks) for full details.

📚&nbsp;&nbsp;[Read the reference documentation](https://checkout.github.io/checkout-mobile-docs/checkout-3ds-sdk-ios/index.html)

### Integrating with any 3DS provider
Standalone 3DS allows our SDKs to be used with any Authentication provider, be it Checkout.com or otherwise. This is a higher touch integration that breaks up the 3DS flow more granularly. In order to integrate with the Standalone 3DS service:

1. Initialize the SDK with your preferred user interface options using our `uiCustomization` object.
2. Create `transaction` object 
3. Get `authenticationRequestParameters` for the AReq
4. If a challenge is mandated from the Authentication response from your 3DS server then call the `doChallenge` method to render the challenge however, if the challenge is not mandated by the ACS then it would have triggered a frictionless 3DS flow. 

#### Diagram
Here is a useful diagram that highlights the end-to-end 3DS flow using our `standalone3DSService`.
![E2E Standalone SDK Flow](https://user-images.githubusercontent.com/102961713/226956636-d39b7bff-9fb8-4701-a3bc-86d932b306f0.jpg)

#### Code snippet 

1. Creates an instance of `ThreeDS2Service` through which the 3DS Requestor App can create a transaction object to get the `authenticationRequestParameters` that are required to perform a challenge:

```swift
   private var transaction: Transaction?
   private var standalone3DSService: ThreeDS2Service?
````

2. Initialize the SDK with your preferred user interface options:

- `scheme` can be set only as `visa` and `mastercard` in lowercase string.

```swift
// initialise Standalone 3DS Service with required parameters

do {
   let directoryServerData = ThreeDS2ServiceConfiguration.DirectoryServerData(directoryServerID: <directoryServerID>,
                                                                              directoryServerPublicKey: <ds_public>,
                                                                              directoryServerRootCertificates: [<caPublic>])
   let configParameters = ThreeDS2ServiceConfiguration.ConfigParameters(directoryServerData: directoryServerData,
                                                                        messageVersion: <messageVersion>,
                                                                        scheme: <scheme>)
    let serviceConfiguration = ThreeDS2ServiceConfiguration(configParameters: configParameters)
      
    self.standalone3DSService = try Standalone3DSService.initialize(with: serviceConfiguration)
   }  catch let error {
      // handle failure scenario
   }
```

3. Create `transaction` using created `ThreeDS2Service` object:

```swift
  self.transaction = self.standalone3DSService?.createTransaction()
```

4. Retrieve the `authenticationRequestParameters`:
```swift
 // get Authentication Request parameters
 self.transaction?.getAuthenticationRequestParameters { result in
     switch result {
     case .success(let params):
        // Make an Authentication Request to your 3DS Server
     case .failure(let error):
        // handle failure scenario
      }
}

```
5. Handle the `doChallenge` flow: 

- If the Authentication response that is returned indicates that the Challenge Flow must be applied, the 3DS Requestor App calls the `doChallenge` method with the required input `ChallengeParameters`. The `doChallenge` method initiates the challenge process.
- The `doChallenge` function now returns a `ChallengeResult` object with `transactionStatus` and `sdkTransactionID`.
```swift
let params = ChallengeParameters(threeDSServerTransactionID: response.transactionId,
                                 acsTransactionID: response.acs.transactionId,
                                 acsRefNumber: response.acs.referenceNumber,
                                 acsSignedContent: response.acs.signedContent)
transaction?.doChallenge(challengeParameters: params, completion: { [weak self]  result in
     switch result {
      case .success(let result):
          // handle success scenario
      case .failure(let error):
         // handle failure scenario
       }
      // call close and cleanUp methods after challenge flow is completed. 
      self?.transaction?.close()
      self?.standalone3DSService?.cleanUp()
})

```

6. Service `cleanUp` and transaction `close`:  

- After a challenge/frictionless flow is completed, you should call:
```swift
    transaction?.close()
    standalone3DSService?.cleanUp()
```

## Dependencies

Our iOS SDK depends on some external libraries:

* To help maintain security, we use [JOSESwift](https://github.com/airsidemobile/JOSESwift).
* To help provide support and monitor the performance of the SDK, we use our own Checkout Event Logger Kit.

## Help and Feedback

**For help using the 3D Secure SDK**, or to pass on your feedback, you can email our team at [support@checkout.com](mailto:support@checkout.com).

**If you’ve found a bug**, we encourage you to open an issue through [GitHub](https://github.com/checkout/checkout-3ds-sdk-ios/issues). If your problem isn’t already listed, please detail the versions of the SDK and your development environment that you’re using, what you were hoping to accomplish, and what the actual result you observed was.


**If you have an idea for a new feature**, we’d also love to hear about it through GitHub. Please [open an issue](https://github.com/checkout/checkout-3ds-sdk-ios/issues), detailing your idea and why it’s important for your project.


## License
This software is released under license. See [LICENSE](https://github.com/checkout/checkout-3ds-sdk-ios/blob/develop/LICENSE.md) for details.

