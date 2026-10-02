# ContentForge 🎨🎬

**Professional Photo & Video Editor for Content Creators**

A modern, CapCut-inspired mobile app built with **Flutter** + **FFmpeg**.  
Perfect for editing pictures, videos, adding effects, text, music, and creating social media content.

> **Status**: Solid foundation ready for development. Clone, run `flutter pub get`, and start building.

---

## 🚀 Features (Roadmap & Current Foundation)

### Photo Editing
- [x] Gallery / Media picker foundation
- [x] Basic crop, rotate, flip
- [ ] Advanced filters & adjustments (brightness, contrast, saturation, HSL)
- [ ] Stickers, overlays, frames
- [ ] Text with fonts, animations, shadows
- [ ] Beauty tools (skin smooth, eyes, etc.)
- [ ] AI background removal (planned)

### Video Editing
- [x] Multi-clip timeline architecture
- [x] Trim / split / reorder clips
- [ ] Transitions between clips
- [ ] Filters & effects (real-time preview planned)
- [ ] Text & animated captions
- [ ] Music & sound effects library
- [ ] Speed control, reverse, freeze frame
- [ ] Keyframe animation
- [ ] Auto captions (AI)

### Content Creation Tools
- [ ] Templates (Reels, TikTok, YouTube Shorts, Stories)
- [ ] Aspect ratio presets (9:16, 1:1, 16:9, 4:5)
- [ ] Export with quality options (720p / 1080p / 4K)
- [ ] Direct share to Instagram, TikTok, YouTube, etc.

---

## 📦 Tech Stack

| Layer              | Technology                          |
|--------------------|-------------------------------------|
| Framework          | Flutter 3.24+                       |
| State Management   | Riverpod / Bloc (flexible)          |
| Video Playback     | video_player + media_kit            |
| Media Processing   | ffmpeg_kit_flutter                  |
| Image Editing      | image + pro_image_editor (optional) |
| UI                 | Material 3 + custom timeline        |
| Architecture       | Clean Architecture + Feature-first  |

---

## 📁 Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── constants/
│   ├── utils/
│   └── services/          # FFmpeg, storage, permissions
├── features/
│   ├── gallery/           # Media picker
│   ├── photo_editor/      # Image editing screens & tools
│   ├── video_editor/      # Timeline, clips, preview
│   ├── export/            # Render & share
│   └── templates/         # Content templates
├── shared/
│   ├── models/            # Project, Clip, Effect, TextLayer
│   ├── widgets/           # Timeline, player, toolbars
│   └── providers/
└── generated/             # Freezed / json_serializable
```

---

## ⚡ Getting Started

### Prerequisites
- Flutter SDK 3.24 or higher
- Android Studio / VS Code with Flutter plugins
- For FFmpeg: follow [ffmpeg_kit_flutter setup](https://github.com/arthenica/ffmpeg-kit)

### Run the app

```bash
git clone https://github.com/jagwazorld-max/ContentForge.git
cd ContentForge
flutter pub get
flutter run
```

### Build APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

For smaller APK (split by ABI):
```bash
flutter build apk --split-per-abi
```

---

## 💡 Design Goals

1. **Smooth timeline** – CapCut-style multi-track experience
2. **Fast preview** – Use hardware acceleration wherever possible
3. **Content-first** – Presets for TikTok/Reels/YouTube Shorts
4. **Extensible** – Easy to add new effects, filters, AI tools
5. **Clean code** – Feature-first + Clean Architecture

---

## 📝 Next Steps (Priority Order)

1. Complete media picker + permissions
2. Basic photo editor (crop + filters)
3. Video player + simple trim
4. Multi-clip timeline UI
5. FFmpeg export pipeline
6. Text overlay system
7. Music library integration
8. Templates system

---

## 👥 Contributing

This is the foundation for a full content creation suite.  
Feel free to open issues or PRs.

---

**Made for creators** • Powered by Flutter + FFmpeg
