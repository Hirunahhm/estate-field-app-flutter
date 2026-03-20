import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estate_field_app/main.dart';

void main() {
  testWidgets('App smoke test — launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: EstateErpApp()));
    await tester.pumpAndSettle();
    // App should launch to login screen with no exceptions
    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
