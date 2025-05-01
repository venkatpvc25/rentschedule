import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/models/tenancy.dart';
import 'package:rentschedule/theme/theme.dart';

class EmptyLandlordDashboard extends StatelessWidget {
  const EmptyLandlordDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final tenancies = auth.profile?.tenancies ?? [];
    final bool isEmpty = tenancies.isEmpty;

    return isEmpty
        ? Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_home,
                  size: 80,
                  color: Colors.deepPurpleAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  'No Tenancies Yet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Start by adding your first property and tenant.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSummaryCards(
              totalTenancies: tenancies.length,
              totalRent: tenancies.fold(
                0,
                (sum, t) => sum + (t.rentAmount ?? 0),
              ),
            ),

            // PendingActionsSection(
            //   pendingActions: ['Confirm rent receipt for 123 Main St'],
            // ),
            TenancyListSection(tenancies: tenancies),
            const SizedBox(height: 24),
          ],
        );
  }
}

class PendingActionsSection extends StatelessWidget {
  final List<String> pendingActions;

  const PendingActionsSection({super.key, required this.pendingActions});

  @override
  Widget build(BuildContext context) {
    if (pendingActions.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Pending Actions"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            elevation: 01,
            child: Column(
              children:
                  pendingActions
                      .map(
                        (action) => ListTile(
                          leading: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.deepOrange,
                          ),
                          title: Text(action),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );
}

class TenancyListSection extends StatelessWidget {
  final List<Tenancy> tenancies;

  const TenancyListSection({super.key, required this.tenancies});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _sectionTitle("Your Tenancies"),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                elevation: 01,
                child: Expanded(
                  child: ListView(
                    children:
                        tenancies
                            .map((tenancy) => buildTenancyCard(tenancy))
                            .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  );

  Widget buildTenancyCard(Tenancy tenancy) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "tenancy.tenantName",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Unit: &, Rent: ₹${tenancy.rentAmount}"),
            SizedBox(height: 4),
            Text("Next Due: ${tenancy.createdAt}"),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("Send Reminder"),
                ),
                OutlinedButton(onPressed: () => {}, child: Text("Renew")),
                OutlinedButton(
                  onPressed: () => {},
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  child: Text("Cancel"),
                ),
                TextButton(onPressed: () => {}, child: Text("View History")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardSummaryCards extends StatelessWidget {
  final int totalTenancies;
  final double totalRent;

  const DashboardSummaryCards({
    super.key,
    required this.totalTenancies,
    required this.totalRent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      color: AppTheme.lightTheme.primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Venkata Chary',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 2,
            children: [
              buildStatCard("Tenancies", "12", Icons.house, Colors.blue),
              buildStatCard(
                "Rents",
                "₹15,000",
                Icons.pending_actions,
                Colors.orange,
              ),
              buildStatCard("Renewals", "3", Icons.update, Colors.purple),
              buildStatCard(
                "Vacant Units",
                "2",
                Icons.meeting_room,
                Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
