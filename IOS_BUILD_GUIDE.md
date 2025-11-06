# iOS Build Guide for Biometric Change Detection App

This guide will help you build and deploy the Biometric Change Detection app for iOS.

## Prerequisites

1. **macOS** - iOS builds require a Mac computer
2. **Xcode** - Install the latest version from the Mac App Store
3. **CocoaPods** - Install via terminal: `sudo gem install cocoapods`
4. **Flutter** - Ensure Flutter is installed and configured
5. **Apple Developer Account** - Required for testing on physical devices and App Store deployment

## Project Configuration

### 1. Bundle Identifier
The app is configured with the bundle identifier: `com.example.biometricChangeDetection`

**For production**, you should change this to your own unique identifier:
- Open `ios/Runner.xcodeproj` in Xcode
- Select the "Runner" target
- Go to "Signing & Capabilities"
- Update the Bundle Identifier to your own (e.g., `com.yourcompany.biometricChangeDetection`)

### 2. iOS Deployment Target
- **Minimum iOS Version**: 13.0
- This is set in both the Xcode project and Podfile

### 3. Permissions
The app requires biometric authentication permissions. This is already configured in `ios/Runner/Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app requires Face ID or Touch ID to detect biometric changes for security purposes.</string>
```

## Build Steps

### Step 1: Install Dependencies

```bash
# Navigate to project directory
cd biometric_change_detection

# Get Flutter packages
flutter pub get

# Navigate to iOS directory
cd ios

# Install CocoaPods dependencies
pod install

# Return to project root
cd ..
```

### Step 2: Configure Signing (Required for Device Testing)

1. Open the project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Select the "Runner" target in the project navigator
3. Go to "Signing & Capabilities" tab
4. Select your Team from the dropdown
5. Xcode will automatically manage provisioning profiles

**Note**: Use `Runner.xcworkspace`, NOT `Runner.xcodeproj` after running `pod install`.

### Step 3: Build for Simulator

```bash
# List available simulators
flutter emulators

# Run on iOS simulator
flutter run -d ios
```

Or use Xcode:
1. Open `ios/Runner.xcworkspace`
2. Select a simulator from the device dropdown
3. Click the Run button (▶️)

### Step 4: Build for Physical Device

```bash
# Connect your iPhone/iPad via USB
# Ensure the device is trusted and unlocked

# List connected devices
flutter devices

# Run on connected device
flutter run -d <device-id>
```

Or use Xcode:
1. Connect your iOS device via USB
2. Open `ios/Runner.xcworkspace`
3. Select your device from the device dropdown
4. Click the Run button (▶️)

**First-time device setup**:
- On your iOS device, go to Settings > General > VPN & Device Management
- Trust the developer certificate

### Step 5: Build Release Version

For App Store or TestFlight distribution:

```bash
# Build release IPA
flutter build ipa

# The IPA will be located at:
# build/ios/ipa/biometric_change_detection.ipa
```

Or build in Xcode:
1. Open `ios/Runner.xcworkspace`
2. Select "Any iOS Device (arm64)" or your connected device
3. Product > Archive
4. Once archived, click "Distribute App"
5. Follow the wizard for App Store Connect or Ad Hoc distribution

## Testing Biometric Functionality

### On Simulator:
1. The simulator supports Face ID simulation
2. Go to Features > Face ID > Enrolled
3. Use Features > Face ID > Matching Face / Non-matching Face to simulate authentication

### On Physical Device:
1. Ensure you have Face ID or Touch ID set up on your device
2. Go to Settings > Face ID & Passcode (or Touch ID & Passcode)
3. Add/remove biometric data to test the change detection

## Common Issues and Solutions

### Issue 1: CocoaPods Installation Fails
```bash
# Update CocoaPods
sudo gem install cocoapods

# Clean and reinstall
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
```

### Issue 2: Signing Errors
- Ensure you're logged into Xcode with your Apple ID
- Go to Xcode > Preferences > Accounts
- Add your Apple ID if not present
- Select your team in the project's Signing & Capabilities

### Issue 3: "Runner.xcworkspace not found"
```bash
cd ios
pod install
```

### Issue 4: Build Fails with Module Not Found
```bash
# Clean build
flutter clean
flutter pub get
cd ios
pod install
cd ..
flutter build ios
```

### Issue 5: Deployment Target Mismatch
- Ensure all pods have the same deployment target (13.0)
- This is handled automatically by the Podfile post_install hook

## App Store Submission Checklist

- [ ] Update Bundle Identifier to your own
- [ ] Configure App Icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset`
- [ ] Update app name in `ios/Runner/Info.plist` (CFBundleDisplayName)
- [ ] Test on multiple iOS devices and versions
- [ ] Create screenshots for App Store listing
- [ ] Prepare app description and metadata
- [ ] Archive and upload to App Store Connect
- [ ] Submit for review

## Build Configurations

The project includes three build configurations:
- **Debug**: For development with debugging enabled
- **Profile**: For performance profiling
- **Release**: For production builds (optimized, no debugging)

## Additional Resources

- [Flutter iOS Deployment Guide](https://docs.flutter.dev/deployment/ios)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [CocoaPods Documentation](https://guides.cocoapods.org/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)

## Support

For issues specific to the biometric change detection plugin, refer to:
- [flutter_biometric_change_detector package](https://pub.dev/packages/flutter_biometric_change_detector)

---

**Note**: This app requires actual biometric hardware (Face ID or Touch ID) to function properly. The simulator has limited biometric simulation capabilities.
