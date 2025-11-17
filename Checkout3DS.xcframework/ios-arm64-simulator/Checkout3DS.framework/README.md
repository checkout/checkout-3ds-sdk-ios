# Crash Reporter Module

This module provides a decoupled crash reporting architecture that can be easily extracted and used independently.

## Architecture

The crash reporter module uses a protocol-based design with complete decoupling from the main SDK:

### Core Components

1. **CrashReporterProtocol** - Defines the interface for any crash reporter implementation
2. **CrashReportLogger** - Abstract logger interface that decouples from the internal SDK logger
3. **PLCrashReporterModule** - Standalone PLCrashReporter implementation
4. **CrashReporterManager** - Manages multiple crash reporters

## Logger Decoupling

The module is completely decoupled from the internal CheckoutComponents `Logger` through the `CrashReportLogger` protocol:

```swift
public protocol CrashReportLogger: AnyObject {
    func logCrashReport(_ crashReport: String)
}
```

This allows the crash reporter module to work independently without any dependency on the internal logger implementation.

### Integration

When used within CheckoutComponents, a bridge adapter (`CheckoutCrashReportLogger`) connects the abstract logger to the internal implementation:

```swift
// Internal adapter (stays with CheckoutComponents)
final class CheckoutCrashReportLogger: CrashReportLogger {
    private weak var logger: Logger?
    
    func logCrashReport(_ crashReport: String) {
        logger?.log(content: .crashDetection(crashReport))
    }
}
```

## Extracting the Module

To extract PLCrashReporter to an external repository:

1. **Copy these files to the new repository:**
   - `CrashReporterProtocol.swift`
   - `CrashReportLogger.swift` (only the protocol)
   - `PLCrashReporterModule.swift`

2. **Create your own logger implementation:**
   ```swift
   // Example custom logger in external repo
   class CustomCrashLogger: CrashReportLogger {
       func logCrashReport(_ crashReport: String) {
           // Your custom logging implementation
           print("CRASH: \(crashReport)")
           // Send to your crash service, file, etc.
       }
   }
   ```

3. **Use the module:**
   ```swift
   let crashReporter = PLCrashReporterModule()
   let logger = CustomCrashLogger()
   
   crashReporter.enableCrashReporting(with: logger)
   ```

## Module Structure

```
CrashReporter/
├── CrashReporterProtocol.swift    # Core protocol (can be extracted)
├── CrashReportLogger.swift        # Logger abstraction (can be extracted)
├── PLCrashReporterModule.swift    # Standalone implementation (can be extracted)
├── CrashReporterManager.swift     # Manager (stays with SDK)
└── README.md                      # This file
```

### What to Extract

When moving to an external repository, extract only:
- The protocol definitions (`CrashReporterProtocol`, `CrashReportLogger`)
- The implementation (`PLCrashReporterModule`)

### What Stays

These components remain in CheckoutComponents:
- `CrashReporterManager` - SDK-specific management
- `CheckoutCrashReportLogger` - Adapter for internal logger
- Integration code in Configuration

## Benefits

1. **Zero Dependencies** - The module has no dependency on CheckoutComponents internals
2. **Protocol-Based** - Easy to mock and test
3. **Flexible Logging** - Implement your own logger for any logging system
4. **Clean Separation** - Can be used in any iOS project, not just CheckoutComponents

## Testing

The module includes its own test utilities:
- `MockCrashReportLogger` - For testing crash report logging
- Protocol-based design enables easy mocking

## Example External Repository Structure

```
PLCrashReporterSDK/
├── Sources/
│   ├── CrashReporterProtocol.swift
│   ├── CrashReportLogger.swift
│   └── PLCrashReporterSDK.swift (renamed from PLCrashReporterModule)
├── Tests/
│   └── PLCrashReporterSDKTests.swift
└── Package.swift
```
