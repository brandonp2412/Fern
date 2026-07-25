import 'package:flutter_test/flutter_test.dart';

import 'package:fern_money/main.dart';

void main() {
  testWidgets('App renders setup screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FernMoneyApp());

    expect(find.text('Connect to Akahu'), findsOneWidget);
    expect(find.text('Connect'), findsOneWidget);
  });
}
