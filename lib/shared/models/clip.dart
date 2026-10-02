import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum ClipType { video, image, audio }

class MediaClip extends Equatable {
  final String id;
  final String path;
  final ClipType type;
  final Duration startTime;      // Position on the timeline
  final Duration duration;       // How long it plays on timeline
  final Duration sourceStart;    // Trim start in original file
  final Duration sourceDuration; // Original media duration
  final double volume;
  final double speed;
  final double scale;
  final double rotation;
  final String? filterId;
  final Map<String, dynamic> effects;

  const MediaClip({
    required this.id,
    required this.path,
    required this.type,
    required this.startTime,
    required this.duration,
    required this.sourceStart,
    required this.sourceDuration,
    this.volume = 1.0,
    this.speed = 1.0,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.filterId,
    this.effects = const {},
  });

  factory MediaClip.create({
    required String path,
    required ClipType type,
    required Duration sourceDuration,
    Duration startTime = Duration.zero,
  }) {
    return MediaClip(
      id: const Uuid().v4(),
      path: path,
      type: type,
      startTime: startTime,
      duration: sourceDuration,
      sourceStart: Duration.zero,
      sourceDuration: sourceDuration,
    );
  }

  MediaClip copyWith({
    Duration? startTime,
    Duration? duration,
    Duration? sourceStart,
    double? volume,
    double? speed,
    double? scale,
    double? rotation,
    String? filterId,
    Map<String, dynamic>? effects,
  }) {
    return MediaClip(
      id: id,
      path: path,
      type: type,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      sourceStart: sourceStart ?? this.sourceStart,
      sourceDuration: sourceDuration,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      filterId: filterId ?? this.filterId,
      effects: effects ?? this.effects,
    );
  }

  /// End time on the timeline
  Duration get endTime => startTime + duration;

  @override
  List<Object?> get props => [
        id,
        path,
        type,
        startTime,
        duration,
        sourceStart,
        volume,
        speed,
        filterId,
      ];
}
