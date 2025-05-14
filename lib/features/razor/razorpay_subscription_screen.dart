import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/razor/razorpay_provider.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/screens/landlord_successfull_subscription.dart';
import 'package:rentschedule/strings.dart';
import 'package:rentschedule/utils/form_field_wrapper.dart';
import 'package:rentschedule/utils/form_vlidators.dart';
import 'package:rentschedule/utils/utils.dart';
import 'package:rentschedule/widgets/base_screen.dart';
import 'package:rentschedule/widgets/bulleting_point.dart';
import 'package:rentschedule/widgets/global_loader_screen.dart';

// TODO: Razorpay Addons

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final loader = Provider.of<LoaderProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => RazorpayProvider(RazorpayService(), loader),
      child: Consumer<RazorpayProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.subscriptionTitle)),
            body:
                provider.shortUrl == null
                    ? GlobalLoaderScreen(
                      child: BaseScreen(
                        child: Form(
                          key: provider.formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '📋 How Subscription Works',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const BulletText(
                                  "This will auto-charge your tenant every billing cycle.",
                                ),
                                const BulletText(
                                  "Tenant must authorize payment through Razorpay after you share the link.",
                                ),
                                const BulletText(
                                  "Razorpay handles recurring billing securely.",
                                ),
                                const BulletText(
                                  "You only need to enter a few required fields to set this up.",
                                ),
                                const BulletText(
                                  "Tenant email, amount, Billing Count, and Start Date are mandatory.",
                                ),
                                const SizedBox(height: 24),
                                FormFieldWrapper(
                                  child: TextFormField(
                                    key: const ValueKey('email'),
                                    controller: provider.emailController,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!isValidEmail(value)) {
                                        return 'Enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                FormFieldWrapper(
                                  child: TextFormField(
                                    controller: provider.amountController,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: validateAmount,
                                  ),
                                ),
                                FormFieldWrapper(
                                  child: TextFormField(
                                    controller: provider.totalCountController,
                                    decoration: InputDecoration(
                                      labelText: 'No of Months',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty)
                                        return 'Required';
                                      final count = int.tryParse(val);
                                      if (count == null || count < 1)
                                        return 'Must be at least 1';
                                      return null;
                                    },
                                  ),
                                ),
                                FormFieldWrapper(
                                  child: TextFormField(
                                    controller: provider.quantityController,
                                    decoration: InputDecoration(
                                      labelText: 'Billing Cycle',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                FormFieldWrapper(
                                  child: TextFormField(
                                    controller: provider.startDateController,
                                    decoration: const InputDecoration(
                                      labelText: 'Start Date',
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      FocusScope.of(context).requestFocus(
                                        FocusNode(),
                                      ); // to prevent keyboard

                                      DateTime? pickedDate =
                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              Duration(days: 365 * 2),
                                            ),
                                          );

                                      if (pickedDate != null) {
                                        provider.startDateController.text =
                                            pickedDate.toIso8601String().split(
                                              'T',
                                            )[0];
                                        provider.startAt =
                                            pickedDate; // yyyy-MM-dd
                                      }
                                    },
                                    validator: (val) {
                                      if (val == null || val.isEmpty)
                                        return 'Start date is required';
                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (provider.formKey.currentState!
                                        .validate()) {
                                      provider.createSubscription();
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
                    : LandlordSubscriptionSuccessStepperScreen(
                      subscription: provider.subscription!,
                      shortUrl: provider.shortUrl!,
                      onGoBack: () {},
                      onCancelRequest: () {},
                    ),
            // : BaseScreen(
            //   child: GlobalSuccessScreen(
            //     title: 'Subscription',
            //     message: 'Subscription created successfully!',
            //     child: ShareLinkWidget(
            //       shortUrl: provider.shortUrl!,
            //       deepLink: 'deepLink',
            //       playStoreLink: 'playStoreLink',
            //     ),
            //     details: [
            //       Text(
            //         'Subscription Amount: ${provider.amountController.text}',
            //       ),
            //     ],
            //     onGoBack: () {
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SubscriptionListScreen(),
            //         ),
            //         (route) => false,
            //       );
            //     },
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
