# Biometric Change Detection Demo

This is a complete demo application showcasing the `flutter_biometric_change_detector` package functionality.

## 🎯 What This Demo Does

This app demonstrates how to detect when a user adds or removes biometric authentication (fingerprint/Face ID) on their device. This is useful for security-sensitive applications that need to know when biometric credentials have changed.

## 📱 Features

- **Biometric Change Detection**: Detects when fingerprints or Face ID are added/removed
- **Baseline Establishment**: Stores initial biometric state for comparison
- **Change History**: Keeps a log of all detected biometric changes
- **Visual Feedback**: Clear status messages with emojis for easy understanding
- **Reset Functionality**: Ability to reset the baseline and start fresh

## 🚀 How to Run

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run on Android**:
   ```bash
   flutter run
   ```

3. **Run on iOS**:
   ```bash
   flutter run
   ```

## 📋 Prerequisites

### Android
- Android device or emulator with API level 23 or higher
- At least one fingerprint enrolled in device settings

### iOS
- iOS device or simulator with iOS 11 or higher
- Face ID or Touch ID configured

## 🧪 How to Test

1. **Launch the app** on your device

2. **Establish Baseline**:
   - Tap "Check Biometric Status"
   - The app will store the current biometric state

3. **Make Changes**:
   - Go to your device settings
   - **Android**: Settings → Security → Fingerprint
   - **iOS**: Settings → Face ID & Passcode (or Touch ID & Passcode)
   - Add or remove a fingerprint/face

4. **Detect Changes**:
   - Return to the app
   - Tap "Check Biometric Status" again
   - The app will detect and display the change!

5. **View History**:
   - Scroll down to see the change history
   - All biometric events are logged with timestamps

6. **Reset** (Optional):
   - Tap "Reset Baseline" to clear history and start over

## 🔧 Technical Details

### Package Used
- `flutter_biometric_change_detector: ^1.0.3`
- `shared_preferences: ^2.2.2` (for storing baseline state)

### How It Works

The package uses platform-specific APIs to detect biometric changes:

- **Android**: Uses `BiometricManager` to track changes in enrolled biometrics
- **iOS**: Uses `LAContext` to detect changes in biometric authentication

The app stores the initial biometric state and compares it on subsequent checks to detect any changes.

### Key Methods

```dart
// Detect if biometric has changed
final hasChanged = await FlutterBiometricChangeDetector.detectBiometricChange();
```

This method returns:
- `true` if biometrics have changed since the last check
- `false` if biometrics remain unchanged

## 📝 Permissions

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

### iOS (Info.plist)
```xml
<key>NSFaceIDUsageDescription</key>
<string>This app requires Face ID or Touch ID to detect biometric changes for security purposes.</string>
```

## 💡 Use Cases

This functionality is valuable for:

1. **Banking Apps**: Detect if a new fingerprint was added to prevent unauthorized access
2. **Security Apps**: Monitor biometric changes for audit trails
3. **Authentication Systems**: Re-authenticate users when biometrics change
4. **Compliance**: Meet security requirements that mandate biometric change detection

## 🐛 Troubleshooting

### "Biometrics not available"
- Ensure your device has biometric hardware
- Check that at least one fingerprint/face is enrolled
- Verify permissions are granted

### "Error: PlatformException"
- Make sure you've run `flutter pub get`
- Check that permissions are properly configured
- Try running `flutter clean` and rebuilding

### Changes Not Detected
- The package tracks changes from the first baseline
- Make sure you've established a baseline first
- Try resetting the baseline and testing again

## 📚 Additional Resources

- [Package Documentation](https://pub.dev/packages/flutter_biometric_change_detector)
- [Flutter Biometric Authentication](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options#local_auth)

## 🎨 UI Features

- **Material Design 3**: Modern, clean interface
- **Responsive Layout**: Works on all screen sizes
- **Color-Coded Status**: Different colors for different states
- **Scrollable Content**: All content accessible on small screens
- **Loading Indicators**: Visual feedback during checks

## 📄 License

This demo is provided as-is for educational and demonstration purposes.
