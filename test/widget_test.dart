import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:next_me/main.dart';

void main() {
  testWidgets('App loads PIN screen', (WidgetTester tester) async {
    await tester.pumpWidget(NextMeApp());

    // Check if the PIN input field is present
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Enter 4-digit PIN'), findsOneWidget);
  });
}
