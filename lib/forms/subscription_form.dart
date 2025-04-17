import 'package:flutter/material.dart';
import 'package:rentschedule/strings.dart';
import 'package:rentschedule/utils/form_field_wrapper.dart';
import 'package:rentschedule/utils/utils.dart';

class SubscriptionDetailsForm extends StatelessWidget {
  final TextEditingController amountController;

  const SubscriptionDetailsForm({required this.amountController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Subscription Details",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 10),
        FormFieldWrapper(
          child: TextFormField(
            controller: amountController,
            decoration: InputDecoration(labelText: AppStrings.amountLabel),
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
      ],
    );
  }
}
