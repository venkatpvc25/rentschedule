class SubscriptionRequest {
  final int totalCount;
  final int quantity;
  final int amount;
  final int? startAt;
  final String email;

  SubscriptionRequest({
    required this.totalCount,
    required this.quantity,
    required this.amount,
    required this.startAt,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'quantity': quantity,
      'amount': amount,
      'email': email,
      if (startAt != null) 'startAt': startAt,
    };
  }

  @override
  String toString() => toJson().toString();
}
