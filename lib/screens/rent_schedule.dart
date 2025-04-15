import 'package:flutter/material.dart';

class RentScheduleScreen extends StatelessWidget {
  const RentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rent Schedule')),
      body: Center(
        child: const Text('This is the Rent Schedule screen.'),
      ),
    );
  }
}