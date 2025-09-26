import 'package:auth_desktop_app/core/app_color.dart';
import 'package:auth_desktop_app/presentation/UI/registration.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/background_image.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_buttons.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/left_image_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
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
                      Home(width: 80, height: 80),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageSide(width: 50, height: 80),
                    Home(width: 40, height: 80),
                  ],
                ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.width, required this.height});
  final double width, height;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    databaseFactory = databaseFactoryFfiWeb;
    loadUsers();
  }

  void loadUsers() async {
    final db = await openDatabase('auth.db');
    final data = await db.query('users');
    setState(() {
      users = data;
    });
  }

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
                  ).showSnackBar(SnackBar(content: Text('Copied'), backgroundColor: AppMainColor.primaryColor,));
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
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user['id'].toString())),
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    subtitle: Text(user['email']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
