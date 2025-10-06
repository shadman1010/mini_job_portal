import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job.dart';

class JobService {
  static const _baseUrl = 'https://dummyjson.com';

  Future<List<Job>> fetchJobs() async {
    final res = await http.get(Uri.parse('$_baseUrl/products'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final list = (data['products'] as List).cast<Map<String, dynamic>>();
      return list.map(Job.fromJson).toList();
    }
    throw Exception('Failed to load jobs');
  }
}
