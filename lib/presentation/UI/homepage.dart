import 'package:auth_desktop_app/presentation/UI/registration.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/background_image.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_buttons.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/left_image_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: ResponsiveSize.isMobile
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      ImageSide(width: 80, height: 45),
                      FormSide(width: 80, height: 80),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageSide(width: 50, height: 80),
                    FormSide(width: 40, height: 80),
                  ],
                ),
        ),
      ),
    );
  }
}

class FormSide extends StatefulWidget {
  const FormSide({super.key, required this.width, required this.height});
  final double width, height;

  @override
  State<FormSide> createState() => _FormSideState();
}

class _FormSideState extends State<FormSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.w(widget.width),
      height: ResponsiveSize.h(widget.height),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 20),
            Text(
              "Welcome to KLM",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            Text(
              "Developer: Hasibur Rahman Khurasani Jawad",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Portfolio: https://hrkjawad.netlify.app/",
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: 'https://hrkjawad.netlify.app/'),
                ).then((_) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Copied')));
                });
              },
              icon: Icon(Icons.copy_all, color: Colors.blue),
            ),
            CustomTextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration()),
                );
              },
              text: 'Go to Registration Page',
            ),
          ],
        ),
      ),
    );
  }
}
