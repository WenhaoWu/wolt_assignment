import 'dart:math';

import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

String randomStr() {
  final r = Random();
  return String.fromCharCodes(
      List.generate(r.nextInt(100), (index) => r.nextInt(33) + 89));
}

bool randomBool() {
  final str = randomStr();
  return str.length.isOdd;
}

int randomInt({int min = 0, int max = 10}) {
  return Random().nextInt(max - min + 1) + min;
}

Restaurant randomRestaurant() {
  return Restaurant(
    name: randomStr(),
    shortDescription: randomStr(),
    imgUrl: randomStr(),
    isFavourite: randomBool(),
  );
}

Item randomItem() {
  return Item(
    image: Image(blurhash: randomStr(), url: randomStr()),
    venue: Venue(
      id: randomStr(),
      name: randomStr(),
      shortDescription: randomStr(),
      location: [randomInt().toDouble(), randomInt().toDouble()],
    ),
  );
}
