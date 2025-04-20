class SubscriptionRequest {
  final int totalCount;
  final int quantity;
  final int amount;
  final int? startAt;

  SubscriptionRequest({
    required this.totalCount,
    required this.quantity,
    required this.amount,
    required this.startAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'quantity': quantity,
      'amount': amount,
      if (startAt != null) 'start_at': startAt,
    };
  }

  @override
  String toString() => toJson().toString();
}
