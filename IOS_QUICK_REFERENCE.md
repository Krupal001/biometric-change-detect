# iOS Quick Reference

## 🚀 Essential Commands

### Initial Setup
```bash
# Install Flutter dependencies
flutter pub get

# Install iOS dependencies
cd ios
pod install
cd ..
```

### Building & Running

```bash
# Run on iOS Simulator
flutter run -d ios

# Run on connected iPhone/iPad
flutter run -d <device-id>

# List available devices
flutter devices

# Build release version
flutter build ios --release

# Build for App Store
flutter build ipa
```

### Opening in Xcode
```bash
# Open workspace (ALWAYS use this after pod install)
open ios/Runner.xcworkspace

# DO NOT use this (will cause issues)
# open ios/Runner.xcodeproj
```

### Troubleshooting

```bash
# Clean everything
flutter clean

# Reinstall pods
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..

# Get dependencies again
flutter pub get

# Rebuild
flutter build ios
```

### CocoaPods

```bash
# Install CocoaPods (one-time setup)
sudo gem install cocoapods

# Update CocoaPods
sudo gem update cocoapods

# Install dependencies
cd ios
pod install

# Update dependencies
pod update

# Install with verbose output (for debugging)
pod install --verbose
```

## 📋 Key Information

| Item | Value |
|------|-------|
| **Minimum iOS Version** | 13.0 |
| **Bundle Identifier** | com.example.biometricChangeDetection |
| **App Name** | Biometric Change Detection |
| **Required Permission** | NSFaceIDUsageDescription ✅ |
| **Swift Version** | 5.0 |

## 📁 Important Files

```
ios/
├── Podfile                          # CocoaPods configuration
├── Runner.xcworkspace/              # Open this in Xcode ⭐
├── Runner.xcodeproj/                # Don't open directly
└── Runner/
    ├── Info.plist                   # App permissions & metadata
    ├── AppDelegate.swift            # App entry point
    └── Assets.xcassets/             # App icons & images
```

## ✅ Pre-Build Checklist

- [ ] Run `flutter pub get`
- [ ] Run `cd ios && pod install`
- [ ] Open `Runner.xcworkspace` in Xcode
- [ ] Configure code signing (Signing & Capabilities)
- [ ] Select correct Team
- [ ] Update Bundle Identifier (if needed)
- [ ] Test build on simulator
- [ ] Test build on physical device

## 🔧 Xcode Configuration

### Code Signing (Required for Device Testing)
1. Open `ios/Runner.xcworkspace`
2. Select "Runner" target
3. Go to "Signing & Capabilities" tab
4. Select your Team
5. Xcode will auto-manage provisioning

### Update Bundle Identifier
1. In Xcode, select "Runner" target
2. Go to "Signing & Capabilities"
3. Change Bundle Identifier
4. Update in `ios/Runner.xcodeproj/project.pbxproj` as well

### Add App Icons
1. Open `ios/Runner/Assets.xcassets/AppIcon.appiconset`
2. Drag and drop icon images
3. Required sizes: 20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024

## 🧪 Testing

### Simulator
```bash
# List simulators
flutter emulators

# Run on specific simulator
flutter run -d "iPhone 15 Pro"

# Simulate Face ID
# In Simulator: Features > Face ID > Enrolled
# Then: Features > Face ID > Matching Face
```

### Physical Device
```bash
# Connect device via USB
# Unlock device and trust computer

# List connected devices
flutter devices

# Run on device
flutter run -d <device-id>

# First time: Settings > General > VPN & Device Management
# Trust the developer certificate
```

## 🐛 Common Issues

### "No such module" error
```bash
flutter clean
cd ios
pod install
cd ..
flutter build ios
```

### "Runner.xcworkspace not found"
```bash
cd ios
pod install
```

### Signing errors
- Ensure you're logged into Xcode (Preferences > Accounts)
- Select a valid Team in Signing & Capabilities
- Update Bundle Identifier to avoid conflicts

### Build fails after updating dependencies
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

## 📱 Device Requirements

### For Development
- iOS device with iOS 13.0 or later
- USB cable
- Device must be registered in Apple Developer Portal (free account OK)

### For Biometric Testing
- Device with Face ID or Touch ID
- Biometric authentication must be set up in Settings

## 🎯 Build Targets

| Target | Command | Use Case |
|--------|---------|----------|
| **Debug** | `flutter run` | Development, debugging |
| **Profile** | `flutter run --profile` | Performance testing |
| **Release** | `flutter build ios --release` | Production testing |
| **IPA** | `flutter build ipa` | App Store submission |

## 📚 Documentation Links

- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [Apple Developer](https://developer.apple.com/)
- [CocoaPods](https://cocoapods.org/)
- [Xcode](https://developer.apple.com/xcode/)

## 💡 Tips

1. **Always use `Runner.xcworkspace`** after running `pod install`
2. **Clean build** if you encounter strange errors
3. **Update CocoaPods** regularly for latest fixes
4. **Test on real device** for accurate biometric testing
5. **Keep Xcode updated** for latest iOS SDK support

## 🆘 Getting Help

If you encounter issues:
1. Check [IOS_BUILD_GUIDE.md](IOS_BUILD_GUIDE.md) for detailed instructions
2. Review [IOS_SETUP_CHECKLIST.md](IOS_SETUP_CHECKLIST.md)
3. Run `flutter doctor -v` to check your setup
4. Check the [flutter_biometric_change_detector](https://pub.dev/packages/flutter_biometric_change_detector) package documentation

---

**Quick Start**: `flutter pub get && cd ios && pod install && cd .. && flutter run -d ios`
