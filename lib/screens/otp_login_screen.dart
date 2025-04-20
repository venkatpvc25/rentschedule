import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/razor/subscription_list_screen.dart';
import 'package:rentschedule/providers/otp_auth_provider.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen({required this.phone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  int seconds = 30;
  late Timer timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      canResend = false;
      seconds = 30;
    });

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (seconds == 0) {
        t.cancel();
        setState(() {
          canResend = true;
        });
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<OtpAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Enter OTP sent to ${widget.phone}"),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: "OTP"),
              keyboardType: TextInputType.number,
            ),
            if (auth.error != null)
              Text(auth.error!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                final success = await auth.verifyOTP(
                  widget.phone.trim(),
                  otpController.text.trim(),
                );

                if (success) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => SubscriptionListScreen()),
                    (route) => false,
                  );
                }
              },
              child:
                  auth.isLoading ? CircularProgressIndicator() : Text("Verify"),
            ),
            SizedBox(height: 16),
            if (!canResend) Text("Resend OTP in $seconds seconds"),
            if (canResend)
              TextButton(
                onPressed: () async {
                  await auth.signInWithPhone(widget.phone.trim());
                  startCountdown();
                },
                child: Text("Resend OTP"),
              ),
          ],
        ),
      ),
    );
  }
}
