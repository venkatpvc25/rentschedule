import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _startPayment() {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY_ID',
      'amount': 50000, // Amount is in paise => 500.00 INR
      'name': 'Your App Name',
      'description': 'Rent Payment',
      'prefill': {'contact': '9999999999', 'email': 'user@example.com'},
      'theme': {'color': '#3399cc'},
      'method': {'upi': true}, // Enables UPI option
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Send success to backend
    print("Payment Success: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: _startPayment,
          child: Text("Pay with Razorpay"),
        ),
      ),
    );
  }
}
