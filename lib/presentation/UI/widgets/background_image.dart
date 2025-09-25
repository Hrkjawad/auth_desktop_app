import 'package:auth_desktop_app/core/image_path.dart';
import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            ImagePath.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child
      ],
    );
  }
}