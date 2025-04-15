import 'package:flutter/material.dart';

class AddTenantTenancyScreen extends StatelessWidget {
  const AddTenantTenancyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Tenant/Tenancy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tenant Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the tenant name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tenancy Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tenancy details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform add tenant/tenancy logic
                  }
                },
                child: const Text('Add Tenant/Tenancy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}