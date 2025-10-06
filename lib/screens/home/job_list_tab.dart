import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/job_list_provider.dart';
import '../../providers/saved_jobs_provider.dart';
import '../../models/job.dart';
import '../job_detail_screen.dart';
import '../../widgets/role_icon.dart';

class JobListTab extends StatelessWidget {
  const JobListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobListProvider>(
      builder: (_, prov, __) {
        if (prov.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (prov.error != null) {
          return Center(
            child: Text('Error: ${prov.error}'),
          );
        }
        if (prov.jobs.isEmpty) {
          return const Center(child: Text('No jobs'));
        }
        return RefreshIndicator(
          onRefresh: prov.fetchJobs,
          child: ListView.builder(
            itemCount: prov.jobs.length,
            itemBuilder: (_, i) => JobCard(job: prov.jobs[i]),
          ),
        );
      },
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final savedProv = context.watch<SavedJobsProvider>();
    final applied = savedProv.isSaved(job.id);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoleIcon(job.role, size: 56),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.role, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(job.company),
                    Text(job.location, style: const TextStyle(color: Colors.grey)),
                    Text('Salary: ${job.salary.toStringAsFixed(0)}'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: applied ? null : () => savedProv.apply(job),
                child: Text(applied ? 'Applied' : 'Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
