import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/models/profiles.dart';
import 'package:rentschedule/services/onboarding_service.dart';
import 'package:rentschedule/utils/global_error_handler.dart';
import 'package:rentschedule/widgets/base_screen.dart';
import 'package:rentschedule/widgets/global_loader_screen.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({super.key, this.onEmailVerified});
  final void Function(String email)? onEmailVerified;

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: GlobalLoaderScreen(
          child: BaseScreen(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child:
                        auth.isOptSent
                            ? Padding(
                              key: const ValueKey('otp'),
                              padding: const EdgeInsets.all(20),
                              child: OtpTextField(
                                numberOfFields: 6,
                                borderColor: const Color(0xFF512DA8),
                                showFieldAsBox: false,
                                onCodeChanged: (String code) {},
                                onSubmit: (String verificationCode) {
                                  auth.otpController.text = verificationCode;
                                },
                              ),
                            )
                            : TextFormField(
                              key: const ValueKey('email'),
                              controller: auth.emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (!auth.isOptSent) {
                        if (_formKey.currentState!.validate()) {
                          final result = await auth.sendOtp();
                          if (result.success) {
                            context.showMessage(
                              result.message ?? 'OTP sent successfully',
                            );
                          } else {
                            context.showError(
                              result.message ?? 'Error sending OTP',
                            );
                          }
                        }
                      } else {
                        final result = await auth.signInWithOtp(
                          onVerified: (user) async {
                            if (user != null) {
                              final result = await OnboardingService()
                                  .onBoardingUser(
                                    Profiles.fromSupabaseUser(user),
                                  );
                              auth.profile = result.data;
                              context.pushReplacementNamed('dashboard');
                            } else {
                              context.showError('Invalid OTP');
                            }
                          },
                        );
                        if (!result.success) {
                          context.showError(
                            result.message ?? 'Error verifying OTP',
                          );
                        }
                      }
                    },
                    child: Text(!auth.isOptSent ? 'Send OTP' : 'Verify OTP'),
                  ),
                  if (auth.isOptSent)
                    TextButton(
                      onPressed: () {
                        auth.isOptSent = false;
                      },
                      child: const Text('Change Email'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
