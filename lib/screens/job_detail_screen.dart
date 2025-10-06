import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/job.dart';
import '../providers/saved_jobs_provider.dart';
import '../widgets/role_icon.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;
  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
  final savedProv = context.watch<SavedJobsProvider>();
  final applied = savedProv.isSaved(job.id);
    return Scaffold(
      appBar: AppBar(
  title: Text(job.role),
        // We no longer show a bookmark toggle; applying is done via button below.
        actions: const [],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: RoleIcon(job.role, size: 96)),
          const SizedBox(height: 12),
          Text(job.company, style: Theme.of(context).textTheme.titleMedium),
          Text(job.location),
          const SizedBox(height: 8),
          Text('Salary: ${job.salary.toStringAsFixed(0)}'),
          const SizedBox(height: 16),
          Text(job.summary),
          const SizedBox(height: 24),
          Text('Responsibilities', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...job.responsibilities.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(r)),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: Text(applied ? 'Applied' : 'Apply'),
            onPressed: applied ? null : () => savedProv.apply(job),
          )
        ],
      ),
    );
  }
}
