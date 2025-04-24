import 'package:flutter/material.dart';

class FormFieldWrapper extends StatelessWidget {
  final Widget child;
  final String? label;

  const FormFieldWrapper({super.key, required this.child, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Global padding
      child: Column(
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(label!),
            ),
          child,
        ],
      ),
    );
  }
}
