import 'package:flutter/material.dart';

class AddTenantProvider extends ChangeNotifier {
  String tenantName = '';
  String tenancyDetails = '';

  void updateTenantName(String value) {
    tenantName = value;
    notifyListeners();
  }

  void updateTenancyDetails(String value) {
    tenancyDetails = value;
    notifyListeners();
  }

  bool validateTenantDetails() {
    return tenantName.isNotEmpty && tenancyDetails.isNotEmpty;
  }
}