import 'package:flutter/material.dart';
import 'package:rentschedule/models/rent_payment.dart';
import 'package:rentschedule/screens/rent_payment_details.dart';

class RentPaymentsListPage extends StatelessWidget {
  final List<RentPayment> payments;

  const RentPaymentsListPage({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    final unpaid = payments.where((p) => !p.paid).toList();
    final paid = payments.where((p) => p.paid).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rent Payments'),
          bottom: const TabBar(tabs: [Tab(text: 'Unpaid'), Tab(text: 'Paid')]),
        ),
        body: TabBarView(
          children: [
            _buildPaymentList(context, unpaid, isPaid: false),
            _buildPaymentList(context, paid, isPaid: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentList(
    BuildContext context,
    List<RentPayment> list, {
    required bool isPaid,
  }) {
    if (list.isEmpty) {
      return Center(
        child: Text(isPaid ? 'No paid rents yet.' : 'No unpaid rents.'),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final payment = list[index];
        return _buildCard(context, payment);
      },
    );
  }

  Widget _buildCard(BuildContext context, RentPayment payment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('Due: ${_formatDate(payment.dueDate)}'),
        subtitle: Text('Amount: ₹${payment.amount.toStringAsFixed(2)}'),
        trailing: Icon(
          payment.paid ? Icons.check_circle : Icons.pending,
          color: payment.paid ? Colors.green : Colors.orange,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RentPaymentDetailsPage(payment: payment),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
