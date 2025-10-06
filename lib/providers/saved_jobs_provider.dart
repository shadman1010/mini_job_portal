import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/job.dart';

class SavedJobsProvider extends ChangeNotifier {
  static late Box _box;
  // Jobs the user has applied to (saved locally)
  List<Job> saved = [];

  static Future<void> init() async {
    _box = await Hive.openBox('saved_jobs');
  }

  SavedJobsProvider() {
    load();
  }

  void load() {
    final list = _box.values.cast<Map>().toList();
    saved = list.map((m) => Job.fromJson(Map<String, dynamic>.from(m))).toList();
    notifyListeners();
  }

  bool isSaved(int id) => saved.any((j) => j.id == id);

  // Apply to a job (idempotent). If already applied, does nothing.
  Future<void> apply(Job job) async {
    if (isSaved(job.id)) return; // already applied
    await _box.add({
      'id': job.id,
      'title': job.role,
      'brand': job.company,
      'price': job.salary / 1000,
      'description': job.summary,
      'thumbnail': job.image,
    });
    load();
  }

  int get count => saved.length;
}
