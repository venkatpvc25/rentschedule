import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/razor/razorpay_provider.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/features/razor/subscription_list_screen.dart';
import 'package:rentschedule/forms/subscription_form.dart';
import 'package:rentschedule/forms/tenant_form.dart';
import 'package:rentschedule/strings.dart';
import 'package:rentschedule/widgets/global_loader_screen.dart';
import 'package:rentschedule/widgets/successfull_screen.dart';

// landlord subscription screen
// This screen allows the landlord to create a subscription for the tenant
// using Razorpay. It includes a form for the landlord to enter their email,
// contact number, and the amount for the subscription. Upon submission,

// need to change from here that once subscription is created, it should
// send an email to tenant with the subscription link
// and the tenant should be able to pay the subscription using Razorpay
// landlord needs to move to  succcssfully subscription created screen with tenant details on it.

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    contactController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RazorpayProvider(RazorpayService()),
      child: Consumer<RazorpayProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.subscriptionTitle)),
            body:
                provider.shortUrl == null
                    ? GlobalLoaderScreen(
                      isLoading: provider.isLoading,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LandlordForm(
                                  emailController: emailController,
                                  contactController: contactController,
                                ),
                                SizedBox(height: 20),
                                SubscriptionDetailsForm(
                                  amountController: amountController,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      provider.createSubscription(
                                        emailController.text,
                                        contactController.text,
                                        int.parse(amountController.text),
                                      );
                                    }
                                  },
                                  child: Text(AppStrings.startSubscription),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    : GlobalSuccessScreen(
                      title: 'Subscription',
                      message: 'Subscription created successfully!',
                      details: [
                        Text('Tenant Email: ${emailController.text}'),
                        Text('Tenant Contact: ${contactController.text}'),
                        Text('Subscription Amount: ${amountController.text}'),
                      ],
                      onGoBack: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionListScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
