# iOS 3D Secure SDK from Checkout.com

The Checkout.com 3D Secure (3DS) mobile SDK allows you to provide a native 3DS2 experience in your mobile app, with visual styling that you can control. 

The SDK handles the device data collection, communication with the card issuer, and presentation of 3D Secure challenges to the customer when required. 

👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://docs.checkout.com/3d-secure-mobile-sdks)

📚&nbsp;&nbsp;Read the reference documentation


## Features
1. Supports **3D Secure protocols 2.1.0 and 2.2.0.**
2. Presents **native 3DS2 challenge screens to the user, with styling that you can customise** to best fit your apps and branding.
3. Optionally **falls back to 3DS1** when 3DS2 is not available, returning the same authentication result to your app as for 3DS2. (This option can be configured by Checkout.com for your account.)
4. Supports a **range of local languages and accessibility needs**, and allows you to set your own string translations.
5. Meets requirements from **EMVCo and the PCI Security Standards Council**, specifically set for 3DS SDKs, so you can be sure it is interoperable with card issuers and that your customers’ sensitive data stays secure.

## Minimum Requirements
The 3DS SDK for iOS requires Xcode 12.0 and above with Swift version 5.3 and above, and supports apps targeting iOS 11.0 and above. It also supports Objective-C.

## Getting Started

First, integrate the 3DS SDK into your app.

Then, configure your app to:

1. Initialize the SDK with your preferred user interface options.
2. Request the SDK to authenticate the cardholder.
3. Consume the result you get from the SDK to continue your payment flow.


👉&nbsp;&nbsp;[See the Integration Guide with Code Examples](https://docs.checkout.com/3d-secure-mobile-sdks) for full details.

📚&nbsp;&nbsp;Read the reference documentation

## Dependencies

The iOS SDK depends on some external libraries:

* To help maintain security, we use [JOSESwift](https://github.com/airsidemobile/JOSESwift).
* To help provide support and monitor the performance of the SDK, we use our own Checkout Event Logger Kit.

## Help and Feedback

**For help using the 3D Secure SDK**, or to pass on your feedback, you can email our team at [support@checkout.com](mailto:support@checkout.com).

**If you’ve found a bug**, we encourage you to open an issue through [GitHub](https://github.com/checkout/checkout-3ds-sdk-ios/issues). If your problem isn’t already listed, please detail the versions of the SDK and your development environment that you’re using, what you were hoping to accomplish, and what the actual result you observed was.


**If you have an idea for a new feature**, we’d also love to hear about it through GitHub. Please [open an issue](https://github.com/checkout/checkout-3ds-sdk-ios/issues), detailing your idea and why it’s important for your project.


## License
[See LICENSE](https://github.com/checkout/checkout-3ds-sdk-ios/blob/feature/PIMOB_770_documentation/LICENSE) for details.

