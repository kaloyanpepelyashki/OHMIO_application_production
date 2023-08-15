import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pin_tunnel_application_production/pages/login_page.dart';

void main() {
  testWidgets('Displays email and password input fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LogInPage()));

    expect(find.byType(TextField), findsNWidgets(2));
  });
}