import 'package:flutter/material.dart';

import '../../../shared/widgets/default_text_form_field.dart';
import '../../../shared/widgets/defaulte_botton.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot_password';
  TextEditingController emailController = .new();
  GlobalKey<FormState> formKey = .new();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.asset('assets/images/forgot-password.png'),
              DefaultTextFormField(
                hintText: 'Email',
                prefixIconImageName: 'email',
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                },
                controller: emailController,
              ),
              SizedBox(height: 24),
              DefaulteBotton(text: 'Verify Email', onPressed: forgotPassword),
            ],
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    if (formKey.currentState!.validate()) {}
  }
}
