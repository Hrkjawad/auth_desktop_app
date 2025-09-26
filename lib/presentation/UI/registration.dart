import 'dart:math';
import 'package:auth_desktop_app/data/model/user_info.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/background_image.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_buttons.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_textformfield.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/left_image_side.dart';
import 'package:auth_desktop_app/presentation/UI/login.dart';
import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../View Model/auth.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
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
  final _auth = Auth();

  final _formKey2 = GlobalKey<FormState>();

  final _emailTEController = TextEditingController();

  final _passwordTEController = TextEditingController();

  final _firstNameTEController = TextEditingController();

  final _lastNameTEController = TextEditingController();

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Container(
        width: ResponsiveSize.w(widget.width),
        height: ResponsiveSize.h(widget.height),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Create your KLM account",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
              CustomTextFormField(
                controller: _firstNameTEController,
                requiredField: true,
                hintText: "First Name",
                textInputType: TextInputType.text,
                isPasswordField: false,
                textInputAction: TextInputAction.next,
              ),
              CustomTextFormField(
                controller: _lastNameTEController,
                hintText: "Last Name",
                textInputType: TextInputType.text,
                isPasswordField: false,
                textInputAction: TextInputAction.next,
              ),
              CustomTextFormField(
                controller: _emailTEController,
                requiredField: true,
                hintText: 'Email Address',
                textInputType: TextInputType.emailAddress,
                isPasswordField: false,
                textInputAction: TextInputAction.next,
              ),
              CustomTextFormField(
                controller: _passwordTEController,
                requiredField: true,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPasswordField: true,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 30),
              CustomElevatedButton(
                onPressed: () async {
                  Random random = Random();
                  if (_formKey2.currentState!.validate()) {
                    final user = UserInfo(
                      id: random.nextInt(100),
                      firstName: _firstNameTEController.text,
                      lastName: _lastNameTEController.text,
                      email: _emailTEController.text,
                      password: _passwordTEController.text,
                    );

                    final success = await _auth.register(user);
                    if (!context.mounted) return;
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registered Successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _firstNameTEController.clear();
                      _lastNameTEController.clear();
                      _emailTEController.clear();
                      _passwordTEController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to Register, Please try again"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      }
                    }
                  }
                },
                text: 'SIGN UP',
              ),
              SizedBox(height: 20),
              CustomTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                text: 'Already have an account?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
