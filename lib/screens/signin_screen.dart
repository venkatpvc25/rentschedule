import 'package:flutter/material.dart';
import 'package:rentschedule/utils/form_field_wrapper.dart';
import 'package:rentschedule/widgets/base_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      //appBar: AppBar(title: const Text('Sign In')),
      body: BaseScreen(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormFieldWrapper(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  //onChanged: provider.updateEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              FormFieldWrapper(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  //onChanged: provider.updatePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Perform sign-in logic
                  }
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Don’t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}