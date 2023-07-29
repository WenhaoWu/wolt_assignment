import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

void main() {
  testWidgets('Golden test', (WidgetTester tester) async {
    await tester.pumpWidget(const Loading());
    await expectLater(find.byType(Loading), matchesGoldenFile('golden/loading.png'));
  });
}
