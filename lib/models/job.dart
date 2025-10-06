class Job {
  final int id;
  final String role; // role/title of the job
  final String company; // synthesized or from brand
  final String location; // placeholder since API lacks location
  final double salary; // placeholder derived from price
  final String summary; // short description snippet
  final List<String> responsibilities; // bullet list
  final String image;

  Job({
    required this.id,
    required this.role,
    required this.company,
    required this.location,
    required this.salary,
    required this.summary,
    required this.responsibilities,
    required this.image,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    final rawDesc = (json['description'] ?? '') as String;
  // Derive a role from a predefined list ignoring the product's original title.
  final role = _roles[(json['id'] as int) % _roles.length];
    final baseCompany = (json['brand'] ?? 'Tech Corp') as String;
    // Synthesize some responsibilities deterministically using id hash
    final id = json['id'] as int;
    final seed = id % _responsibilityTemplates.length;
    final templates = _responsibilityTemplates[seed];
    final resp = <String>{};
    resp.addAll(templates.map((t) => t.replaceAll('{ROLE}', role)));
    resp.add('Collaborate with cross-functional teams to deliver features.');
    resp.add('Maintain code quality and participate in reviews.');
    return Job(
      id: id,
      role: role,
  company: "$baseCompany Ltd",
      location: _locations[id % _locations.length],
      salary: (json['price'] is num) ? (json['price'] as num).toDouble() * 1000 : 0.0,
      summary: rawDesc,
      responsibilities: resp.toList(),
      image: (json['thumbnail'] ?? ''),
    );
  }
}

// Some pseudo-random responsibilities templates.
const List<List<String>> _responsibilityTemplates = [
  [
    'Design and implement scalable {ROLE} solutions',
    'Optimize performance and ensure reliability',
  ],
  [
    'Write clean, testable code for {ROLE} features',
    'Troubleshoot and debug production issues',
  ],
  [
    'Analyze requirements and translate into {ROLE} tasks',
    'Contribute to architectural decisions',
  ],
  [
    'Improve developer tooling around {ROLE}',
    'Document technical decisions and APIs',
  ],
];

const List<String> _locations = [
  'Remote',
  'New York, NY',
  'San Francisco, CA',
  'Berlin, Germany',
  'Toronto, Canada',
  'London, UK',
];

// Predefined roles to replace arbitrary product titles.
const List<String> _roles = [
  'Junior Software Engineer',
  'Senior Software Engineer',
  'Mobile Developer',
  'Backend Engineer',
  'Frontend Engineer',
  'DevOps Engineer',
  'Cloud Architect',
  'QA Engineer',
  'Automation Tester',
  'Product Manager',
  'Project Manager',
  'Scrum Master',
  'UI/UX Designer',
  'Data Analyst',
  'Data Engineer',
  'Data Scientist',
  'ML Engineer',
  'Security Engineer',
  'Site Reliability Engineer',
  'Database Administrator',
  'SQL Analyst',
  'Business Analyst',
  'Solutions Architect',
  'Technical Lead',
  'Engineering Manager',
  'Director of Engineering',
  'VP of Engineering',
  'CTO',
  'CIO',
  'CEO',
  'Intern Software Engineer',
  'Junior QA Analyst',
  'Support Engineer',
  'IT Administrator',
  'Network Engineer',
  'Full Stack Developer',
  'Android Developer',
  'iOS Developer',
  'Flutter Developer',
  'React Native Developer',
  'Growth Engineer',
  'Platform Engineer',
  'Blockchain Developer',
  'AR/VR Developer',
  'Game Developer',
  'Technical Writer',
  'Customer Success Engineer',
  'Release Manager',
  'Build Engineer',
  'Performance Engineer',
  'Infrastructure Engineer',
];
