import 'package:flutter_test/flutter_test.dart';

import 'package:fern/main.dart';

void main() {
  testWidgets('App renders setup screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FernApp());

    expect(find.text('Connect to Akahu'), findsOneWidget);
    expect(find.text('Connect'), findsOneWidget);
  });
}
