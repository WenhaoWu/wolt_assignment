import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

import '../../helpers/random.dart';

void main() {
  group('RestaurantStatusX', () {
    test('returns correct values for RestaurantStatus.initial', () {
      const status = RestaurantStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for RestaurantStatus.loading', () {
      const status = RestaurantStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for RestaurantStatus.success', () {
      const status = RestaurantStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for RestaurantStatus.failure', () {
      const status = RestaurantStatus.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });

  group('toJson/fromJson', () {
    test('work properly', () {
      final state = RestaurantState(
        status: RestaurantStatus.success,
        restaurants: List.filled(randomInt(), randomRestaurant()),
        favIDs: List.filled(randomInt(), randomStr()).toSet(),
      );
      expect(
        RestaurantState.fromJson(state.toJson()),
        state,
      );
    });
  });
}
