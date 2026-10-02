import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

class ContentForgeApp extends ConsumerWidget {
  const ContentForgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ContentForge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      // We use dark theme by default (like CapCut)
      home: const HomeScreen(),
    );
  }
}
