import 'package:auth_desktop_app/core/responsive.dart';
import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../../../core/image_path.dart';

class ImageSide extends StatelessWidget {
  const ImageSide({super.key, required this.width, required this.height});
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.w(width),
      height: ResponsiveSize.h(height),
      color: AppMainColor.primaryColor.withValues(alpha: 0.6),
      child: Stack(
        alignment: Alignment(0, 0),
        children: [
          Positioned(
            top: ResponsiveSize.isMobile ? -10 : 50,
            child: Image.asset(
              ImagePath.klmLogo,
              width: ResponsiveSize.isMobile
                  ? ResponsiveSize.w(35)
                  : ResponsiveSize.w(40),
              height: ResponsiveSize.isMobile
                  ? ResponsiveSize.h(25)
                  : ResponsiveSize.h(30),
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          Image.asset(ImagePath.airplaneImage),
        ],
      ),
    );
  }
}
