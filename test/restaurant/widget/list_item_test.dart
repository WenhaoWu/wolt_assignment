import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

void main() {
  // Skip due to http call (for google font and imageUrl) is missing in widget test
  testWidgets('Golden test', skip: true, (WidgetTester tester) async {
    const restaurant = Restaurant(
      id: "id",
      name: "name",
      shortDescription: "shortDescription",
      imgUrl: "imgUrl",
      isFavourite: true,
    );
    await tester
        .pumpWidget(const MaterialApp(home: ListItem(restaurant: restaurant)));
    await expectLater(
        find.byType(ListItem), matchesGoldenFile('golden/list_item.png'));
  });
}
