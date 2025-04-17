import 'package:flutter/material.dart';
import 'package:rentschedule/strings.dart';
import 'package:rentschedule/utils/form_field_wrapper.dart';
import 'package:rentschedule/utils/utils.dart';

class LandlordForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController contactController;

  const LandlordForm({
    required this.emailController,
    required this.contactController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Landlord Details",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 10),
        FormFieldWrapper(
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: AppStrings.emailLabel),
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
            decoration: InputDecoration(labelText: AppStrings.contactLabel),
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
      ],
    );
  }
}
