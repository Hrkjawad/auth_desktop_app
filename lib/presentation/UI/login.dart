import 'package:auth_desktop_app/presentation/UI/homepage.dart';
import 'package:auth_desktop_app/presentation/UI/registration.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/background_image.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_buttons.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_textformfield.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/left_image_side.dart';
import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../View Model/auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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

  final _formKey = GlobalKey<FormState>();

  final _emailTEController = TextEditingController();

  final _passwordTEController = TextEditingController();

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: ResponsiveSize.w(widget.width),
        height: ResponsiveSize.h(widget.height),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(height: 20),
                Text(
                  "Login to your KLM account",
                  style: TextStyle(fontSize: 22, color: Colors.blue),
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
                CustomElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await _auth.login(
                        _emailTEController.text,
                        _passwordTEController.text,
                      );
                      if (!mounted) return;
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Success"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        _emailTEController.clear();
                        _passwordTEController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid Email or Password"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  text: 'LOGIN',
                ),
                CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration()),
                    );
                  },
                  text: 'Create an account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
