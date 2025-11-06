# iOS Configuration

## Quick Setup

This directory contains the iOS-specific configuration for the Biometric Change Detection app.

### Prerequisites
- macOS with Xcode installed
- CocoaPods installed (`sudo gem install cocoapods`)
- Flutter SDK configured

### Initial Setup

1. **Install Dependencies**:
   ```bash
   # From the project root
   flutter pub get
   
   # Install CocoaPods dependencies
   cd ios
   pod install
   cd ..
   ```

2. **Open in Xcode**:
   ```bash
   open ios/Runner.xcworkspace
   ```
   ⚠️ **Important**: Always open `Runner.xcworkspace`, NOT `Runner.xcodeproj`

3. **Configure Signing**:
   - Select the "Runner" target
   - Go to "Signing & Capabilities"
   - Select your development team
   - Update Bundle Identifier if needed (currently: `com.example.biometricChangeDetection`)

### Key Files

- **Podfile**: CocoaPods dependency configuration
- **Runner/Info.plist**: App metadata and permissions
- **Runner.xcworkspace**: Xcode workspace (use this to open the project)
- **Runner.xcodeproj**: Xcode project file

### Permissions

The app requires biometric authentication. The following permission is already configured in `Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app requires Face ID or Touch ID to detect biometric changes for security purposes.</string>
```

### Deployment Target

- **Minimum iOS Version**: 13.0
- Configured in both Xcode project and Podfile

### Building

**For Simulator**:
```bash
flutter run -d ios
```

**For Physical Device**:
```bash
flutter run -d <device-id>
```

**For Release**:
```bash
flutter build ipa
```

### Troubleshooting

If you encounter build issues:

```bash
# Clean and rebuild
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter pub get
```

For detailed instructions, see the [IOS_BUILD_GUIDE.md](../IOS_BUILD_GUIDE.md) in the project root.
