import 'package:flutter/material.dart';

class RoleIcon extends StatelessWidget {
  final String role;
  final double size;
  const RoleIcon(this.role, {super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    final mapping = _roleMapping(role);
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: mapping.background,
      child: Text(
        mapping.emoji,
        style: TextStyle(fontSize: size * 0.55),
      ),
    );
  }
}

_RoleVisual _roleMapping(String role) {
  final lower = role.toLowerCase();
  if (_containsAny(lower, ['security', 'devops', 'sre', 'infrastructure', 'platform'])) {
    return const _RoleVisual('🔒', Colors.indigo);
  }
  if (_containsAny(lower, ['data', 'ml', 'sql'])) {
    return const _RoleVisual('📊', Colors.deepPurple);
  }
  if (_containsAny(lower, ['manager', 'director', 'vp', 'cto', 'cpo', 'ceo', 'lead', 'product', 'project', 'scrum'])) {
    return const _RoleVisual('🧩', Colors.teal);
  }
  if (_containsAny(lower, ['designer', 'ui', 'ux'])) {
    return const _RoleVisual('🎨', Colors.pinkAccent);
  }
  if (_containsAny(lower, ['qa', 'test'])) {
    return const _RoleVisual('🧪', Colors.orange);
  }
  if (_containsAny(lower, ['support', 'customer', 'success'])) {
    return const _RoleVisual('💬', Colors.blueGrey);
  }
  if (_containsAny(lower, ['writer'])) {
    return const _RoleVisual('✏️', Colors.brown);
  }
  if (_containsAny(lower, ['network', 'cloud'])) {
    return const _RoleVisual('☁️', Colors.lightBlue);
  }
  if (_containsAny(lower, ['intern'])) {
    return const _RoleVisual('🌱', Colors.green);
  }
  // Default engineering/dev roles
  return const _RoleVisual('💻', Colors.blueAccent);
}

bool _containsAny(String base, List<String> needles) => needles.any(base.contains);

class _RoleVisual {
  final String emoji;
  final Color background;
  const _RoleVisual(this.emoji, this.background);
}
