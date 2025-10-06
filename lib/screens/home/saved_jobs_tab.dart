import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../models/job.dart';
import '../job_detail_screen.dart';

class SavedJobsTab extends StatelessWidget {
  const SavedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedJobsProvider>(
      builder: (_, saved, __) {
        if (saved.saved.isEmpty) {
          return const Center(child: Text('No saved jobs yet'));
        }
        return ListView.builder(
          itemCount: saved.saved.length,
          itemBuilder: (_, i) => SavedJobCard(job: saved.saved[i]),
        );
      },
    );
  }
}

class SavedJobCard extends StatelessWidget {
  final Job job;
  const SavedJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
  title: Text(job.role),
        subtitle: Text(job.company),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)),
          );
        },
      ),
    );
  }
}
