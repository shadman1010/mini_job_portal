import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/models/job.dart';

void main() {
  test('Job.fromJson transforms product to job model', () {
    const sample = '{"id":1,"title":"Phone","brand":"BrandX","price":100,"description":"Great","thumbnail":"img.png"}';
    final map = jsonDecode(sample) as Map<String, dynamic>;
    final job = Job.fromJson(map);
    expect(job.id, 1);
    // Company now appends 'Ltd'
    expect(job.company, 'BrandX Ltd');
    // Salary derived (price * 1000)
    expect(job.salary, 100000);
    // Role comes from predefined list, just validate it's non-empty
    expect(job.role.isNotEmpty, true);
    // Responsibilities should not be empty
    expect(job.responsibilities.isNotEmpty, true);
  });
}
