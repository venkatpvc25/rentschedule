class RentPayment {
  final int paymentId;
  final int? tenancyId;
  final DateTime dueDate;
  final bool paid;
  final DateTime? paidAt;
  final double amount;
  final String? paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  RentPayment({
    required this.paymentId,
    this.tenancyId,
    required this.dueDate,
    required this.paid,
    this.paidAt,
    required this.amount,
    this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RentPayment.fromJson(Map<String, dynamic> json) {
    return RentPayment(
      paymentId: json['payment_id'],
      tenancyId: json['tenancy_id'],
      dueDate: DateTime.parse(json['due_date']),
      paid: json['paid'] ?? false,
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      amount: (json['amount'] as num).toDouble(),
      paymentStatus: json['payment_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
