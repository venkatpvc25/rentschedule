import 'package:rentschedule/models/subscription_request.dart';

class TenantRequest {
  //final Tenant tenant;
  final int amount;
  final SubscriptionRequest subscriptionRequest;

  TenantRequest({
    //required this.tenant,
    required this.amount,
    required this.subscriptionRequest,
  });

  Map<String, dynamic> toJson() {
    return {
      //'tenant': tenant.toJson(),
      'amount': amount,
      'subscriptionRequest': subscriptionRequest.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();
}
