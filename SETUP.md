# ContentForge Setup Guide

## 1. Clone & Install

```bash
git clone https://github.com/jagwazorld-max/ContentForge.git
cd ContentForge
flutter pub get
```

## 2. Enable FFmpeg (Important)

Uncomment the FFmpeg dependency in `pubspec.yaml`:

```yaml
dependencies:
  ffmpeg_kit_flutter_min_gpl: ^6.0.3
```

Then run:
```bash
flutter pub get
```

> Note: Full GPL version is larger but supports more codecs/filters.

## 3. Android Permissions

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

Also set `android:requestLegacyExternalStorage="true"` on the `<application>` tag for older Android.

## 4. iOS Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photos and videos to edit them.</string>
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture new content.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for video recording.</string>
```

## 5. Run

```bash
flutter run
```

## 6. Build Release APK

```bash
flutter build apk --release
# or for smaller size:
flutter build apk --split-per-abi --release
```

The APK will be in `build/app/outputs/flutter-apk/`.

---

**You now have a solid foundation.**  
Next recommended tasks: implement real FFmpeg calls, multi-track timeline UI, and filter system.
