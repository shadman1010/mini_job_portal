import 'package:flutter/foundation.dart';
import '../models/job.dart';
import '../services/job_service.dart';

class JobListProvider extends ChangeNotifier {
  final JobService _service = JobService();
  List<Job> jobs = [];
  bool loading = false;
  String? error;

  Future<void> fetchJobs() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      jobs = await _service.fetchJobs();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
