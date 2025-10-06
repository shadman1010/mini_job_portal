import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/models/job.dart';

void main() {
  test('Job.fromJson parses product', () {
    const sample = '{"id":1,"title":"Phone","brand":"BrandX","price":100,"description":"Great","thumbnail":"img.png"}';
    final map = jsonDecode(sample) as Map<String, dynamic>;
    final job = Job.fromJson(map);
    expect(job.id, 1);
    expect(job.company, 'BrandX');
    expect(job.salary, 100000); // price * 1000
  });
}
