import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_theme.dart';
import '../photo_editor/photo_editor_screen.dart';
import '../video_editor/video_editor_screen.dart';

class GalleryScreen extends StatefulWidget {
  final bool isVideoMode;

  const GalleryScreen({super.key, required this.isVideoMode});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickFromGallery() async {
    setState(() => _isLoading = true);
    try {
      if (widget.isVideoMode) {
        final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
        if (video != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => VideoEditorScreen(initialVideoPath: video.path),
            ),
          );
        }
      } else {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PhotoEditorScreen(imagePath: image.path),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickFromCamera() async {
    setState(() => _isLoading = true);
    try {
      if (widget.isVideoMode) {
        final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
        if (video != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => VideoEditorScreen(initialVideoPath: video.path),
            ),
          );
        }
      } else {
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PhotoEditorScreen(imagePath: image.path),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isVideoMode ? 'Select Video' : 'Select Photo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: AppTheme.primary)
            : Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.isVideoMode ? Icons.videocam_rounded : Icons.photo_library_rounded,
                      size: 80,
                      color: AppTheme.primary.withOpacity(0.7),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.isVideoMode
                          ? 'Choose a video to start editing'
                          : 'Choose a photo to start editing',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _pickFromGallery,
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('From Gallery'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _pickFromCamera,
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('From Camera'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primary,
                          side: const BorderSide(color: AppTheme.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
