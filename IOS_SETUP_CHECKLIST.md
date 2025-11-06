# iOS Setup Checklist

## ✅ Completed Configurations

The following iOS configurations have been set up for your biometric change detection app:

### 1. ✅ Podfile Created
- **Location**: `ios/Podfile`
- **iOS Deployment Target**: 13.0
- **Features**:
  - CocoaPods analytics disabled for faster builds
  - Proper Flutter integration
  - Post-install hooks for build settings
  - Bitcode disabled (as required by Flutter)
  - Build library for distribution enabled (Xcode 14+ compatibility)

### 2. ✅ Info.plist Configured
- **Location**: `ios/Runner/Info.plist`
- **Permissions**:
  - ✅ `NSFaceIDUsageDescription`: Configured with appropriate message
- **App Name**: "Biometric Change Detection"
- **Bundle Identifier**: `com.example.biometricChangeDetection`

### 3. ✅ Xcode Project Settings
- **Deployment Target**: iOS 13.0
- **Bundle Identifier**: `com.example.biometricChangeDetection`
- **Swift Version**: 5.0
- **AppDelegate**: Properly configured with Flutter

### 4. ✅ Documentation Created
- ✅ `IOS_BUILD_GUIDE.md`: Comprehensive build instructions
- ✅ `ios/README.md`: Quick reference for iOS setup

## 🔧 Required Actions Before Building

### Action 1: Install CocoaPods Dependencies
```bash
cd ios
pod install
cd ..
```

### Action 2: Configure Code Signing (For Device Testing)
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Runner" target
3. Go to "Signing & Capabilities"
4. Select your Team
5. (Optional) Update Bundle Identifier to your own

### Action 3: Test Build
```bash
# For simulator
flutter run -d ios

# For physical device (after signing)
flutter run -d <device-id>
```

## 📱 Testing on iOS

### Simulator Testing
- Face ID can be simulated in iOS Simulator
- Go to Features > Face ID > Enrolled
- Use Features > Face ID to simulate matching/non-matching faces

### Physical Device Testing
- Requires actual Face ID or Touch ID hardware
- Better for real-world testing
- Go to Settings > Face ID & Passcode to add/remove biometric data

## 🚀 Build Commands

### Development Build (Debug)
```bash
flutter run -d ios
```

### Release Build
```bash
flutter build ios --release
```

### App Store Build
```bash
flutter build ipa
```

## 📋 Pre-Production Checklist

Before submitting to the App Store:

- [ ] Update Bundle Identifier to your own unique ID
- [ ] Add App Icons to `ios/Runner/Assets.xcassets/AppIcon.appiconset`
- [ ] Update app display name if needed
- [ ] Test on multiple iOS devices (iPhone, iPad)
- [ ] Test on different iOS versions (13.0+)
- [ ] Verify biometric detection works correctly
- [ ] Create App Store screenshots
- [ ] Prepare app description and metadata
- [ ] Configure App Store Connect
- [ ] Archive and upload build

## 🔍 Verification Steps

Run these commands to verify your setup:

```bash
# 1. Check Flutter setup
flutter doctor -v

# 2. Verify iOS dependencies
cd ios
pod --version
pod install --verbose
cd ..

# 3. List available iOS devices
flutter devices

# 4. Build for iOS (this will catch any configuration issues)
flutter build ios --debug
```

## 📚 Key Files Reference

| File | Purpose |
|------|---------|
| `ios/Podfile` | CocoaPods dependency management |
| `ios/Runner/Info.plist` | App metadata and permissions |
| `ios/Runner/AppDelegate.swift` | iOS app entry point |
| `ios/Runner.xcworkspace` | Xcode workspace (use this!) |
| `ios/Runner.xcodeproj` | Xcode project file |

## ⚠️ Important Notes

1. **Always open `Runner.xcworkspace`**, not `Runner.xcodeproj` (after running `pod install`)
2. **Minimum iOS version**: 13.0
3. **Biometric permissions**: Already configured in Info.plist
4. **Bundle Identifier**: Currently set to `com.example.biometricChangeDetection` - change for production
5. **Code Signing**: Required for physical device testing and App Store submission

## 🆘 Troubleshooting

If you encounter issues:

```bash
# Clean everything
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter pub get

# Rebuild
flutter build ios
```

## ✨ What's Ready

Your iOS app is now configured and ready to build! All necessary files and permissions are in place. You can:

1. ✅ Build for iOS Simulator
2. ✅ Build for iOS Devices (after code signing)
3. ✅ Test biometric change detection on iOS
4. ✅ Submit to App Store (after updating bundle identifier and adding icons)

## 📖 Next Steps

1. Run `cd ios && pod install` to install dependencies
2. Open the project in Xcode: `open ios/Runner.xcworkspace`
3. Configure code signing with your Apple Developer account
4. Build and test: `flutter run -d ios`

For detailed instructions, refer to [IOS_BUILD_GUIDE.md](./IOS_BUILD_GUIDE.md)
