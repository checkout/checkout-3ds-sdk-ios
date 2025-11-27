![Checkout.com](https://github.com/checkout/checkout-3ds-sdk-ios/assets/102961713/32457abd-3bac-47da-8fad-f3db684a58ae)


# iOS 3D Secure SDK

The Checkout.com 3D Secure (3DS) mobile SDK allows you to provide a native 3DS2 experience in your mobile app, with visual styling that you can control. 

The SDK handles the device data collection, communication with the card issuer, and presentation of 3D Secure challenges to the customer when required. 

- [Features](#features)
- [Minimum Requirements](#minimum-requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Integration](#integration)
  - [Checkout.com's 3DS server](#checkoutcoms-3ds-server)
  - [Any 3DS provider](#any-3ds-provider)
- [Payment Authorisation](#payment-authorisation)
- [Dependencies](#dependencies)
- [Help and Feedback](#help-and-feedback)
- [License](#license)
  
👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://www.checkout.com/docs/risk-management/3d-secure/sessions/non-hosted-sessions/3d-secure-mobile-sdks)

📚&nbsp;&nbsp;[Read the reference documentation](https://checkout.github.io/checkout-mobile-docs/checkout-3ds-sdk-ios/index.html)


## Features
- Supports **3D Secure protocol 2.2.0.**
- Presents **native 3DS2 challenge screens to the user, with styling that you can customise** to best fit your apps and branding.
- Optionally **falls back to 3DS1** when 3DS2 is not available, returning the same authentication result to your app as for 3DS2. (This option can be configured by Checkout.com for your account.)
- Supports a **range of local languages and accessibility needs**, and allows you to set your own string translations.
- Meets requirements from **EMVCo and the PCI Security Standards Council**, specifically set for 3DS SDKs, so you can be sure it is interoperable with card issuers and that your customers’ sensitive data stays secure.

## Minimum Requirements
- The 3DS SDK for iOS requires Xcode 16.1 and above with Swift version 6.1.2 and above, and supports apps targeting iOS 13.0 and above. It also supports Objective-C. 
- We have discontinued support for intel machines (x86_64 architecture based environments). You must use ARM64 architecture based environments to compile our 3DS iOS SDK.


## Installation

We've done our best to support the most common distribution methods on iOS. We are in strong favour of [SPM](#Swift-Package-Manager) (Swift Package Manager)

### Swift Package Manager
>**⚠️ Important** <br>
> SPM (Swift Package Manager) and CocoaPods can usually coexist in the same project without issues. That said, since CocoaPods is now in maintenance mode, the iOS team made a tech decision to officially support only SPM going forward. It’s simpler to manage and already works well alongside CocoaPods if needed.

[Swift Package Manager](https://swift.org/package-manager/) integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies. It should work out of the box on latest Xcode projects since Xcode 11 and has had a lot of community support, seeing huge adoption over the recent years. This is our preferred distribution method for Frames iOS and is the easiest one to integrate, keep updated and build around.

If you've never used it before, get started with Apple's step by step guide into [adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) . 

```swift
.package(url: "https://github.com/checkout/checkout-3ds-sdk-ios", from: "X.Y.Z")
```

`⚙️ Adding Environment Variable for SPM Integration`

You may need to add the following environment variable to your Run Scheme if `Checkout3DS-Security.framework` fails to load:

```swift
<EnvironmentVariable
    key="DYLD_INSERT_LIBRARIES"
    value="$(TARGET_BUILD_DIR)/Checkout3DS.framework/Checkout3DS:$(TARGET_BUILD_DIR)/Checkout3DS-Security.framework/Checkout3DS-Security"
    isEnabled="YES">
</EnvironmentVariable>
```

This environment variable ensures the dynamic libraries are correctly loaded at runtime.

How to add this environment variable:
- Open your Xcode project.
- Go to Edit Scheme for your target.
- Select the Run action.
- Under Environment Variables, add a new entry:
  -  Key: DYLD_INSERT_LIBRARIES
  - Value: ```$(TARGET_BUILD_DIR)/Checkout3DS.framework/Checkout3DS:$(TARGET_BUILD_DIR)/Checkout3DS-Security.framework/Checkout3DS-Security```
  - Ensure the checkbox is enabled.

Then, configure your app to:

## Integration

### Checkout.com's 3DS server
This integration method involves one call to our `authenticate` method, which will perform an entire Authentication flow using Checkout.com's 3DS servers.

1. Initialize the SDK with your preferred user interface options using our `uiCustomization` object.
2. Configure the parameters for an authentication.
3. Request authentication and handle the result to continue your payment flow.
4. The authenticate function now returns `Result` type with two cases
    - `AuthenticationResult` with `transactionStatus` and `sdkTransactionID`  👉&nbsp;&nbsp;[More info about transaction status](https://www.checkout.com/docs/business-operations/use-the-dashboard/payment-activity/track-3ds-events#Transaction_status)
    - `AuthenticationError` with a `message`.

👉&nbsp;&nbsp;Strongly recommend providing the `appURL` parameter as a universal link. [Apple Documentation](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content)

#### Code snippet

```swift
// 1. Init with defaults
let checkout3DS = Checkout3DSService()

// 2. Init with explicit arguments
let checkout3DS = Checkout3DSService(
    environment: .production,
    locale: Locale(identifier: "en_GB"),
    uiCustomization: uiCustomization,
    appURL: URL(string: "https://www.MerchantRequestorAppUniversalLink.com")
)

let authenticationParameters = AuthenticationParameters(
    sessionID: sessionID,
    sessionSecret: sessionSecret,
    scheme: scheme)

checkout3DS.authenticate(authenticationParameters: authenticationParameters) { result in
    switch authenticationResult {
    case .success(let authenticationResult):
        // handle authentication result. Checkout Payment Authorisation section.
    case .failure(let error):
        // handle failure scenarios
     }
}
```
👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://www.checkout.com/docs/risk-management/3d-secure/sessions/non-hosted-sessions/3d-secure-mobile-sdks) for full details.

📚&nbsp;&nbsp;[Read the reference documentation](https://checkout.github.io/checkout-mobile-docs/checkout-3ds-sdk-ios/index.html)

### Any 3DS provider
Standalone 3DS allows our SDKs to be used with any Authentication provider, be it Checkout.com or otherwise. This is a higher touch integration that breaks up the 3DS flow more granularly. In order to integrate with the Standalone 3DS service:

1. Initialize the SDK with your preferred user interface options using our `uiCustomization` object.
2. Create `transaction` object 
3. Get `authenticationRequestParameters` for the AReq
4. If a challenge is mandated from the Authentication response from your 3DS server then call the `doChallenge` method to render the challenge however, if the challenge is not mandated by the ACS then it would have triggered a frictionless 3DS flow. 

#### End-to-end 3DS flow
Here is a useful diagram that highlights the end-to-end 3DS flow using our `standalone3DSService`.
![E2E Standalone SDK Flow](https://user-images.githubusercontent.com/102961713/226956636-d39b7bff-9fb8-4701-a3bc-86d932b306f0.jpg)

#### Code snippet 

1- Creates an instance of `ThreeDS2Service` through which the 3DS Requestor App can create a transaction object to get the `authenticationRequestParameters` that are required to perform a challenge:

```swift
   private var transaction: Transaction?
   private var standalone3DSService: ThreeDS2Service?
````

2-Initialize the SDK with your preferred user interface options:

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
        // make an Authentication Request to your 3DS Server
     case .failure(let error):
        // handle failure scenario
      }
}

```
5. Handle the `doChallenge` flow: 

- If the Authentication response that is returned indicates that the Challenge Flow must be applied, the 3DS Requestor App calls the `doChallenge` method with the required input `ChallengeParameters`. The `doChallenge` method initiates the challenge process.
- The `doChallenge` function now returns `Result` type with two cases
  - `AuthenticationResult` with `transactionStatus` and `sdkTransactionID`  👉&nbsp;&nbsp;[More info about transaction status](https://www.checkout.com/docs/business-operations/use-the-dashboard/payment-activity/track-3ds-events#Transaction_status)
  - `AuthenticationError` with a `message`.


```swift
let params = ChallengeParameters(threeDSServerTransactionID: response.transactionId,
                                 acsTransactionID: response.acs.transactionId,
                                 acsRefNumber: response.acs.referenceNumber,
                                 acsSignedContent: response.acs.signedContent)
transaction?.doChallenge(challengeParameters: params, completion: { [weak self] result in
     switch result {
      case .success(let authenticationResult):
         // handle authentication result. Checkout Payment Authorisation section.
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

## Payment Authorisation
After initiating the authentication process and obtaining the `AuthenticationResult` object, you can continue the authentication flow based on the value of `transStatus`:

| `transStatus` | Description                            | Proceed with Payment Authorisation Request |
| :------------------ | :-------------------------------------- | :--------------------|
| `Y`                 | Authentication verification successful.| Yes |
| `A`                 | Attempt at processing performed.       | Yes |
| `I`                 | Informational only.                    | Yes |
| `N`                 | Not authenticated or account not verified.| No  |
| `R`                 | Authentication or account verification rejected.| No  |
| `U`                 | Authentication or account verification could not be performed.| No  |

 👉&nbsp;&nbsp;[More info about transaction status](https://www.checkout.com/docs/business-operations/use-the-dashboard/payment-activity/track-3ds-events#Transaction_status)

## Dependencies

Our iOS SDK depends on some external libraries:

* To help maintain security, we use [JOSESwift](https://github.com/airsidemobile/JOSESwift). To overcome the limitation in Swift Package Manager (SPM) related to binary target dependencies, we've integrated JOSESwift as an xcframework sourced from the same [JOSESwift](https://github.com/airsidemobile/JOSESwift).
* To help provide support and monitor the performance of the SDK, we use our own Checkout Event Logger Kit.

## Help and Feedback

**For help using the 3D Secure SDK**, or to pass on your feedback, you can email our team at [support@checkout.com](mailto:support@checkout.com).

**If you’ve found a bug**, we encourage you to open an issue through [GitHub](https://github.com/checkout/checkout-3ds-sdk-ios/issues). If your problem isn’t already listed, please detail the versions of the SDK and your development environment that you’re using, what you were hoping to accomplish, and what the actual result you observed was.


**If you have an idea for a new feature**, we’d also love to hear about it through GitHub. Please [open an issue](https://github.com/checkout/checkout-3ds-sdk-ios/issues), detailing your idea and why it’s important for your project.


## License
This software is released under license. See [LICENSE](https://github.com/checkout/checkout-3ds-sdk-ios/blob/main/LICENSE.md) for details.

