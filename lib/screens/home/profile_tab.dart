import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/saved_jobs_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.watch<AuthProvider>().currentEmail ?? 'Unknown';
    final count = context.watch<SavedJobsProvider>().count;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 12),
          Text('Name: Demo User'),
          Text('Email: $email'),
          Text('Saved Jobs: $count'),
        ],
      ),
    );
  }
}
