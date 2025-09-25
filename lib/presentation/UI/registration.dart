import 'package:auth_desktop_app/presentation/UI/widgets/background_image.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_buttons.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/custom_textformfield.dart';
import 'package:auth_desktop_app/presentation/UI/widgets/left_image_side.dart';
import 'package:auth_desktop_app/presentation/UI/login.dart';
import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

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

final _formKey = GlobalKey<FormState>();

final _emailTEController = TextEditingController();

final _firstNameTEController = TextEditingController();

final _lastNameTEController = TextEditingController();

final _passwordTEController = TextEditingController();

class _FormSideState extends State<FormSide> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
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
