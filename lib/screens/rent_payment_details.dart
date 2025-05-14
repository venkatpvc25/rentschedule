import 'package:flutter/material.dart';
import 'package:rentschedule/models/rent_payment.dart';

class RentPaymentDetailsPage extends StatelessWidget {
  final RentPayment payment;

  const RentPaymentDetailsPage({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('Due Date', _formatDate(payment.dueDate)),
            _infoRow('Amount', '₹${payment.amount.toStringAsFixed(2)}'),
            _infoRow('Paid', payment.paid ? 'Yes' : 'No'),
            if (payment.paidAt != null)
              _infoRow('Paid At', _formatDateTime(payment.paidAt!)),
            _infoRow('Status', payment.paymentStatus ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  String _formatDateTime(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
}
