class AppConstants {
  static const String appName = 'ContentForge';
  static const String appVersion = '0.1.0';

  // Export quality presets
  static const Map<String, Map<String, dynamic>> exportPresets = {
    '720p': {'width': 720, 'height': 1280, 'bitrate': '2M'},
    '1080p': {'width': 1080, 'height': 1920, 'bitrate': '5M'},
    '4k': {'width': 2160, 'height': 3840, 'bitrate': '15M'},
  };

  // Supported aspect ratios for content creation
  static const List<String> aspectRatioLabels = [
    '9:16 (TikTok/Reels)',
    '1:1 (Square)',
    '16:9 (YouTube)',
    '4:5 (Instagram)',
  ];
}
