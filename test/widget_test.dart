import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_portal/providers/auth_provider.dart';
import 'package:job_portal/providers/job_list_provider.dart';
import 'package:job_portal/providers/saved_jobs_provider.dart';
import 'package:job_portal/screens/auth/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App starts on Login screen', (tester) async {
    // Initialize Hive in memory for tests
    await Hive.initFlutter();
    await AuthProvider.init();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => JobListProvider()),
          ChangeNotifierProvider(create: (_) => SavedJobsProvider()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

  // First pump builds widgets; second pump lets post-frame callbacks run
  await tester.pump();
  await tester.pump();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
