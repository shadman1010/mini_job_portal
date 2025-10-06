import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_portal/screens/auth/login_screen.dart';
import 'package:job_portal/providers/auth_provider.dart';

// Dummy AuthProvider that does not touch Hive. We override methods that would
// access static boxes and just return failed auth so LoginScreen stays put.
class DummyAuthProvider extends AuthProvider {
  @override
  bool get isLoggedIn => false;
  @override
  String? get currentEmail => null;
  @override
  Future<bool> login(String email, String password) async => false;
  @override
  Future<bool> signUp(String email, String password) async => false;
  @override
  Future<void> logout() async {}
}


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App starts on Login screen', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => DummyAuthProvider()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    await tester.pump();

    // There are two 'Login' texts: AppBar title and the button label.
    expect(find.text('Login'), findsNWidgets(2));
    // Ensure the login ElevatedButton is present.
    expect(
      find.widgetWithText(ElevatedButton, 'Login'),
      findsOneWidget,
    );
    expect(find.text('Create account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
