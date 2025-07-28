import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? networkImageUrl;
  final VoidCallback? onTap;
  final double radius;
  final String? fallbackText;
  final Color? fallbackBgColor;

  const ProfileImagePicker({
    super.key,
    this.imageFile,
    this.onTap,
    this.networkImageUrl,
    this.radius = 48,
    this.fallbackText,
    this.fallbackBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ImageProvider? imageProvider;
    if (imageFile != null) {
      imageProvider = FileImage(imageFile!);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(networkImageUrl!);
    }
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: imageProvider == null
            ? (fallbackBgColor ?? theme.primaryColor.withValues(alpha: 0.2))
            : Colors.transparent,
        backgroundImage: imageProvider,
        child: imageProvider == null
            ? (fallbackText != null && fallbackText!.isNotEmpty
                  ? Text(
                      fallbackText!,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(Icons.camera_alt, size: 40, color: theme.primaryColor))
            : null,
      ),
    );
  }
}
