import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_portal/screens/auth/login_screen.dart';

class FakeAuthProvider extends ChangeNotifier {
  bool get isLoggedIn => false;
  String? get currentEmail => null;
}

class FakeSavedJobsProvider extends ChangeNotifier {
  int get count => 0;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App starts on Login screen', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FakeAuthProvider()),
          ChangeNotifierProvider(create: (_) => FakeSavedJobsProvider()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
