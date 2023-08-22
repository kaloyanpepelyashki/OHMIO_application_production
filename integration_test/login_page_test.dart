import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/main.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {


  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('sign in integration test', (WidgetTester tester) async {
    // Initialize your app
    await tester.pumpWidget(MyApp()); // replace MyApp with your main app widget

    // This is just an example. In a real-world scenario, you might have different UI
    // elements that you'll need to find and interact with, such as text fields for
    // email and password, as well as a sign-in button.

    // Fill out the email and password
    await tester.enterText(find.byKey(Key('emailField')), 'kuba.kolando.02.01@gmail.com'); // Replace with the actual locator
    await tester.enterText(find.byKey(Key('passwordField')), '123456'); // Replace with the actual locator

    // Tap the sign-in button
    await tester.tap(find.byKey(Key('loginButton'))); // Replace with the actual locator for your sign-in button
    await tester.pumpAndSettle();

    // Check if sign in was successful by checking if you are navigated to the home page or checking for a specific widget.
    // For this example, let's assume we're looking for a widget that is only present in the home page.
    expect(find.byKey(Key('emailField')), findsOneWidget);
    expect(find.byKey(Key('passwordField')), findsOneWidget);
    expect(find.byKey(Key('loginButton')), findsOneWidget);

    expect(find.byType(DashBoardPage), findsOneWidget); // Replace HomePageWidget with an actual widget that signifies a successful login.
  });
}