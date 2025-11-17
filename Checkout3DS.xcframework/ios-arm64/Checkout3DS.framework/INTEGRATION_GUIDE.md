# PLCrashReporter Integration Guide for Checkout3DS

## Overview

This guide explains how PLCrashReporter has been integrated into the Checkout3DS SDK for both CocoaPods and Swift Package Manager.

## Architecture

The crash reporter integration uses a modular, decoupled architecture:

```
Checkout3DSService (Main SDK)
    ↓
CrashReporterManager (Lifecycle Owner)
    ↓
PLCrashReporterModule (Crash Detection)
    ↓
Checkout3DSCrashReportLogger (Logger Adapter)
    ↓
CheckoutEventLoggerKit (Logging Backend)
```

## Installation

### CocoaPods

The PLCrashReporter dependency is already added to the Podfile:

```ruby
pod 'PLCrashReporter', '~> 1.11.2'
```

To install:
```bash
cd /path/to/3ds2-sdk-ios
pod install
```

### Swift Package Manager

Add the package dependency to your project:

```swift
dependencies: [
    .package(url: "https://github.com/checkout/3ds2-sdk-ios", from: "1.0.0")
]
```

The Package.swift already includes PLCrashReporter as a dependency.

## Usage

### Automatic Crash Reporting

Crash reporting is automatically enabled when you initialize the Checkout3DS SDK (in non-DEBUG builds).

```swift
// Crash reporting is automatically initialized
let checkout3DS = Checkout3DSService(...)
```

### Manual Control

You can manually control crash reporting:

```swift
// Disable all crash reporters
Checkout3DSService.disableAllCrashReporters()

// Disable specific reporter
Checkout3DSService.disableCrashReporter(identifier: "PLCrashReporter")

// Check if crash reporting is enabled
let isEnabled = Checkout3DSService.isCrashReportingEnabled()

```

## Integration with CheckoutEventLoggerKit

Crash reports are logged through CheckoutEventLoggerKit with the following properties:

```swift
{
    "event_type": "sdk_crash_detected",
    "crash_report": "<detailed crash information>"
}
```

## File Structure

```
Checkout3DS/CrashReporter/
├── CrashReporterProtocol.swift              # Core protocol
├── CrashReportLogger.swift                  # Logger abstraction
├── PLCrashReporterModule.swift              # Crash detection implementation
├── CrashReporterManager.swift               # Crash reporter lifecycle manager
└── README.md                                 # Documentation
```

## Features

✅ **Automatic Initialization** - Enabled on SDK startup (non-DEBUG only)  
✅ **CocoaPods Support** - Full integration with Podfile  
✅ **SPM Support** - Package.swift configured  
✅ **Logger Integration** - Works with CheckoutEventLoggerKit  
✅ **Public API** - Control crash reporting from your app  
✅ **Thread-Safe** - Concurrent queue implementation  
✅ **Modular Design** - Easy to extend or remove  

## Debug vs Release

- **DEBUG**: Crash reporting is disabled by default
- **RELEASE**: Crash reporting is automatically enabled

This prevents unnecessary crash logs during development while ensuring production crashes are captured.

## Crash Report Storage

Crash reports are saved to:
```
Documents/CrashReports/
├── crash_report_<timestamp>.plcrash  # Raw crash data
└── crash_report_<timestamp>.crash    # Formatted report
```

## Testing

To test crash reporting:

1. Build in Release mode
2. Trigger a crash (e.g., force unwrap nil)
3. Restart the app
4. Check CheckoutEventLoggerKit logs for crash report

## Troubleshooting

### Crash reporting not working

1. Verify you're running a Release build
2. Check if crash reporting is enabled:
   ```swift
   print(Checkout3DSService.isCrashReportingEnabled())
   ```
3. Ensure PLCrashReporter pod is installed correctly

### CocoaPods installation issues

```bash
# Clean and reinstall
rm -rf Pods Podfile.lock
pod deintegrate
pod install
```

### SPM integration issues

```bash
# Clean SPM cache
rm -rf .build
swift package clean
swift package resolve
```

## Advanced Configuration

### Adding Custom Crash Reporters

You can add your own crash reporter by implementing `CrashReporterProtocol`:

```swift
class CustomCrashReporter: CrashReporterProtocol {
    let identifier = "CustomReporter"
    var isCrashReportingEnabled = false
    
    func enableCrashReporting(with logger: CrashReportLogger) {
        // Your implementation
    }
    
    func disableCrashReporting() {
        // Your implementation
    }
    
    func processPendingCrashReports() {
        // Your implementation
    }
}

// Register it
CrashReporterManager.shared.register(CustomCrashReporter())
```

## Best Practices

1. **Don't disable in production** - Keep crash reporting enabled for production builds
2. **Monitor crash reports** - Regularly review crash logs in CheckoutEventLoggerKit
3. **Test crash handling** - Verify crash reports are properly logged
4. **Privacy compliance** - Ensure crash reports don't contain sensitive data

## Support

For issues or questions:
1. Check the main README.md
2. Review the ARCHITECTURE.md for design details
3. Contact the Checkout3DS team

## Version History

- **1.0.0** - Initial PLCrashReporter integration
  - CocoaPods support
  - SPM support
  - CheckoutEventLoggerKit integration
  - Public API for crash reporting control

