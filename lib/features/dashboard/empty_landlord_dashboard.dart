import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/models/tenancy.dart';
import 'package:rentschedule/services/tenancy_service.dart';
import 'package:rentschedule/theme/theme.dart';
import 'package:rentschedule/utils/global_error_handler.dart';

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
        : SingleChildScrollView(
          child: Column(
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
          ),
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

  // I need to update tenancies list once I received response from server
  void updateTenancies(
    BuildContext context,
    int tenancyId,
    TenancyAction action,
  ) async {
    final response = await TenancyService().performAction(action, tenancyId);
    if (response.data != null && response.data == true) {
      context.showMessage("Tenancy ${action.name} successfully");
      final auth = Provider.of<AuthProvider>(context, listen: false);
      auth.updateTenancies(tenancyId, action);
    } else {
      context.showError("Unble to cancel tenancy");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _sectionTitle("Your Tenancies"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            elevation: 01,
            child: Column(
              children:
                  tenancies
                      .map((tenancy) => buildTenancyCard(tenancy, context))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  );

  Widget buildTenancyCard(Tenancy tenancy, BuildContext context) {
    return GestureDetector(
      child: Container(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
        //margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${tenancy.tenant?.profile?.fullName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  popupMenu(tenancy, context),
                ],
              ),
              SizedBox(height: 4),
              Text("Unit: &, Rent: ₹${tenancy.rentAmount}"),
              SizedBox(height: 4),
              Text("Next Due: ${tenancy.createdAt}"),
              //SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget popupMenu(Tenancy tenancy, BuildContext context) {
    return PopupMenuButton<TenancyAction>(
      icon: Icon(Icons.more_vert),
      onSelected: (action) async {
        action.perform(
          context: context,
          updateTenancies:
              () => updateTenancies(context, tenancy.tenancyId!, action),
        );
      },
      itemBuilder: (context) {
        return tenancy.availableActions().map((entry) {
          return PopupMenuItem<TenancyAction>(
            value: entry,
            child: Text(entry.value),
          );
        }).toList();
      },
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
