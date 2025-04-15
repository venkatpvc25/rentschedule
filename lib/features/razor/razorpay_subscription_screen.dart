import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/razor/razorpay_provider.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/strings.dart';
import 'package:rentschedule/utils/form_field_wrapper.dart';
import 'package:rentschedule/utils/utils.dart';
import 'package:rentschedule/widgets/global_loader_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late final WebViewController _controller;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    emailController.dispose();
    contactController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
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
                          key: _formKey, // Attach the form key
                          child: Column(
                            children: [
                              FormFieldWrapper(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.emailLabel,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.emailRequired;
                                    } else if (!isValidEmail(value)) {
                                      return AppStrings.emailInvalid;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              FormFieldWrapper(
                                child: TextFormField(
                                  controller: contactController,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.contactLabel,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.contactRequired;
                                    } else if (!isValidPhoneNumber(value)) {
                                      return AppStrings.contactInvalid;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              FormFieldWrapper(
                                child: TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.amountLabel,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.amountRequired;
                                    } else if (!isValidAmount(value)) {
                                      return AppStrings.amountInvalid;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, proceed with the subscription
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
                    )
                    : WebViewWidget(
                      controller:
                          _controller
                            ..loadRequest(Uri.parse(provider.shortUrl!)),
                    ),
          );
        },
      ),
    );
  }
}
