import 'package:auth_desktop_app/presentation/UI/registration.dart';
import 'package:flutter/material.dart';

import 'core/app_color.dart';
import 'core/responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppMainColor.primaryColor,
        brightness: Brightness.light,
      ),
      home: const Registration(),
    );
  }
}
