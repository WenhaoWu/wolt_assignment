import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

void main() {
  testWidgets('Golden test with toggle on', (WidgetTester tester) async {
    const restaurant = Restaurant(
      id: "id",
      name: "name",
      shortDescription: "shortDescription",
      imgUrl: "imgUrl",
      isFavourite: true,
    );
    await tester
        .pumpWidget(const MaterialApp(home: FavouriteAnimatedIcon(restaurant: restaurant)));
    await expectLater(find.byType(FavouriteAnimatedIcon),
        matchesGoldenFile('golden/favourite_animated_icon_on.png'));
  });

  testWidgets('Golden test with toggle off', (WidgetTester tester) async {
    const restaurant = Restaurant(
      id: "id",
      name: "name",
      shortDescription: "shortDescription",
      imgUrl: "imgUrl",
      isFavourite: false,
    );
    await tester
        .pumpWidget(const MaterialApp(home: FavouriteAnimatedIcon(restaurant: restaurant)));
    await expectLater(find.byType(FavouriteAnimatedIcon),
        matchesGoldenFile('golden/favourite_animated_icon_off.png'));
  });
}
