import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/providers/otp_auth_provider.dart';
import 'package:rentschedule/features/razor/subscription_list_screen.dart';

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<OtpAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Phone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child:
              auth.isOtpSent
                  ? _buildOtpInput(context, auth)
                  : _buildPhoneInput(context, auth),
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context, OtpAuthProvider auth) {
    return Column(
      key: ValueKey('phoneInput'),
      children: [
        TextField(
          controller: auth.phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: "Enter Phone Number",
            prefixText: "+91 ",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed:
              auth.isLoading
                  ? null
                  : () async {
                    final success = await auth.sendOTP();
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("OTP sent successfully")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(auth.error ?? "Failed to send OTP"),
                        ),
                      );
                    }
                  },
          child:
              auth.isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text("Send OTP"),
        ),
      ],
    );
  }

  Widget _buildOtpInput(BuildContext context, OtpAuthProvider auth) {
    return Column(
      key: ValueKey('otpInput'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter OTP sent to ${auth.phoneNumber}"),
        SizedBox(height: 20),
        OtpTextField(
          numberOfFields: 6,
          borderColor: Color(0xFF512DA8),
          showFieldAsBox: false,
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) {
            auth.otpController.text = verificationCode;
          },
        ),
        if (auth.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(auth.error!, style: TextStyle(color: Colors.red)),
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed:
              auth.isLoading
                  ? null
                  : () async {
                    final success = await auth.verifyOTP(
                      auth.phoneNumber,
                      auth.otpController.text.trim(),
                    );

                    if (success) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("OTP Verified")));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubscriptionListScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(auth.error ?? "Verification failed"),
                        ),
                      );
                    }
                  },
          child:
              auth.isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text("Verify"),
        ),
        SizedBox(height: 16),
        if (!auth.canResend) Text("Resend OTP in ${auth.seconds} seconds"),
        if (auth.canResend)
          TextButton(
            onPressed:
                auth.isLoading
                    ? null
                    : () async {
                      await auth.resendOTP();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("OTP resent")));
                    },
            child: Text("Resend OTP"),
          ),
      ],
    );
  }
}
