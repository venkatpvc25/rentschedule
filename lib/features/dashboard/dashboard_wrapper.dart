import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'landlord_dashboard.dart';
import 'tenant_dashboard.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.isLandlord()) {
      return const LandlordDashboardScreen();
    } else {
      return const TenantDashboardScreen();
    }
  }
}
