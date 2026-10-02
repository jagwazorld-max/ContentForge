import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PhotoEditorScreen extends StatefulWidget {
  final String imagePath;

  const PhotoEditorScreen({super.key, required this.imagePath});

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  int _selectedTool = 0;
  final List<String> _tools = ['Adjust', 'Filters', 'Text', 'Stickers', 'Crop'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Photo Editor'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Export / Save
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export coming in next update')),
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
          // Image Preview
          Expanded(
            child: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Tool options area
          Container(
            height: 100,
            color: AppTheme.surface,
            child: Center(
              child: Text(
                _tools[_selectedTool] + ' tools will appear here',
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
            ),
          ),

          // Bottom tool bar
          Container(
            height: 80,
            color: AppTheme.surface,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _tools.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTool == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTool = index),
                  child: Container(
                    width: 72,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: AppTheme.primary, width: 1.5)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getToolIcon(index),
                          color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _tools[index],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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

  IconData _getToolIcon(int index) {
    switch (index) {
      case 0:
        return Icons.tune_rounded;
      case 1:
        return Icons.filter_rounded;
      case 2:
        return Icons.text_fields_rounded;
      case 3:
        return Icons.emoji_emotions_outlined;
      case 4:
        return Icons.crop_rounded;
      default:
        return Icons.edit;
    }
  }
}
