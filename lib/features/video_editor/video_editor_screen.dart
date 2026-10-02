import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/clip.dart';

class VideoEditorScreen extends StatefulWidget {
  final String initialVideoPath;

  const VideoEditorScreen({super.key, required this.initialVideoPath});

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  int _selectedTool = 0;
  final List<String> _tools = ['Trim', 'Text', 'Music', 'Filters', 'Speed', 'Effects'];

  // Simple single-clip for now
  late MediaClip _mainClip;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.file(File(widget.initialVideoPath));
    await _controller.initialize();

    final duration = _controller.value.duration;
    _mainClip = MediaClip.create(
      path: widget.initialVideoPath,
      type: ClipType.video,
      sourceDuration: duration,
    );

    setState(() => _isInitialized = true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Video Editor'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export pipeline coming next')),
              );
            },
            child: const Text(
              'Export',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Preview
          Expanded(
            flex: 3,
            child: _isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  ),
          ),

          // Playback controls
          if (_isInitialized)
            Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  Expanded(
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: AppTheme.primary,
                        bufferedColor: Colors.white24,
                        backgroundColor: Colors.white10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDuration(_controller.value.position) +
                        ' / ' +
                        _formatDuration(_controller.value.duration),
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),

          // Timeline placeholder (future multi-track)
          Container(
            height: 90,
            color: AppTheme.surfaceLight,
            child: Center(
              child: Text(
                'Timeline (multi-clip coming soon)\nCurrent clip: ${_formatDuration(_mainClip.duration)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
            ),
          ),

          // Bottom tools
          Container(
            height: 80,
            color: AppTheme.surface,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _tools.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTool == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTool = index),
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getToolIcon(index),
                          color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _tools[index],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  IconData _getToolIcon(int index) {
    switch (index) {
      case 0:
        return Icons.content_cut_rounded;
      case 1:
        return Icons.text_fields_rounded;
      case 2:
        return Icons.music_note_rounded;
      case 3:
        return Icons.filter_rounded;
      case 4:
        return Icons.speed_rounded;
      case 5:
        return Icons.auto_awesome_rounded;
      default:
        return Icons.edit;
    }
  }
}
