import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final double radius;

  const ProfileImagePicker({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.radius = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: theme.primaryColor.withValues(alpha: 0.2),
        backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
        child: imageFile == null
            ? Icon(
                AntDesign.camera_twotone,
                size: 40,
                color: theme.primaryColor,
              )
            : null,
      ),
    );
  }
}
