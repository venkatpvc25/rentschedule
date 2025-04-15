import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/widgets/global_loader_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final password = _passwordController.text.trim();
    final loaderProvider = Provider.of<LoaderProvider>(context, listen: false);

    loaderProvider.showLoader();
    final authService = Provider.of<AuthService>(context, listen: false);
    authService
        .updatePassword(password)
        .then((_) {
          loaderProvider.hideLoader();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully!')),
          );
        })
        .catchError((error) {
          loaderProvider.hideLoader();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $error')));
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<LoaderProvider>(context).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Update Password')),
      body: GlobalLoaderScreen(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8 ||
                        !RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d).+$',
                        ).hasMatch(value)) {
                      return 'Password must be at least 8 characters long and include a letter and a number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _updatePassword,
                  child: const Text('Update Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
