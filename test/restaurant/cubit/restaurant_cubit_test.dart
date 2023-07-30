import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_location/geo_location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

import '../../helpers/hydrated_bloc.dart';

// ignore: must_be_immutable
class MockRestaurant extends Mock implements Restaurant {}

class MockWoltApiClient extends Mock implements WoltApiClient {}

class MockGeoLocationApiClient extends Mock implements GeoLocationApiClient {}

void main() {
  initHydratedStorage();

  late WoltApiClient woltApiClient;
  late GeoLocationApiClient geoLocationApiClient;

  setUp(() async {
    woltApiClient = MockWoltApiClient();
    geoLocationApiClient = MockGeoLocationApiClient();
    when(() => geoLocationApiClient.streamLatLong())
        .thenAnswer((_) => const Stream.empty());
  });

  test('initial state is correct', () {
    final state = RestaurantCubit(woltApiClient, geoLocationApiClient).state;
    expect(state.status.isInitial, true);
    expect(state.restaurants, isEmpty);
  });

  group('toJson/fromJson', () {
    test('work properly', () {
      final cubit = RestaurantCubit(woltApiClient, geoLocationApiClient);
      expect(
        cubit.fromJson(cubit.toJson(cubit.state)),
        cubit.state,
      );
    });
  });

  group('acts based on location stream', () {
    const item = Item(
      image: Image(blurhash: "foo1", url: "foo2"),
      venue: Venue(
        id: "foo3",
        name: "foo4",
        shortDescription: "foo5",
        location: [1, 1],
      ),
    );
    const restaurant = Restaurant(
      id: "foo3",
      name: "foo4",
      shortDescription: "foo5",
      imgUrl: "foo2",
      isFavourite: false,
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'emits no state',
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      expect: () => [],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'emits loading and success state',
      setUp: () {
        when(() => geoLocationApiClient.streamLatLong())
            .thenAnswer((_) => Stream.value(LatLong(1, 1)));
        when(() => woltApiClient.getItems(latitude: 1, longitude: 1))
            .thenAnswer((_) => Future.value([item]));
      },
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      expect: () => [
        RestaurantState(
          status: RestaurantStatus.loading,
          restaurants: List.empty(),
        ),
        RestaurantState(
          status: RestaurantStatus.success,
          restaurants: const [restaurant],
        ),
      ],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'emits loading and error state',
      setUp: () {
        when(() => geoLocationApiClient.streamLatLong())
            .thenAnswer((_) => Stream.value(LatLong(1, 1)));
        when(() => woltApiClient.getItems(latitude: 1, longitude: 1))
            .thenThrow(Exception("error"));
      },
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      expect: () => [
        RestaurantState(
          status: RestaurantStatus.loading,
          restaurants: List.empty(),
        ),
        RestaurantState(
          status: RestaurantStatus.failure,
          restaurants: const [],
        ),
      ],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'emits success state with favIDs',
      setUp: () {
        when(() => geoLocationApiClient.streamLatLong())
            .thenAnswer((_) => Stream.value(LatLong(1, 1)));
        when(() => woltApiClient.getItems(latitude: 1, longitude: 1))
            .thenAnswer((_) => Future.value([item]));
      },
      seed: () => RestaurantState(favIDs: const {"foo3"}),
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      expect: () => [
        RestaurantState(
          status: RestaurantStatus.loading,
          restaurants: List.empty(),
          favIDs: const {"foo3"},
        ),
        RestaurantState(
          status: RestaurantStatus.success,
          restaurants: [restaurant.copyWith(isFavourite: true)],
          favIDs: const {"foo3"},
        ),
      ],
    );
  });

  group('toggle favourite item', () {
    const restaurant = Restaurant(
      id: "foo3",
      name: "foo4",
      shortDescription: "foo5",
      imgUrl: "foo2",
      isFavourite: false,
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'Can toggle restaurant on',
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      seed: () => RestaurantState(restaurants: const [restaurant]),
      act: (cubit) => cubit.toggleFavourite(restaurant),
      expect: () => [
        isA<RestaurantState>()
            .having((state) => state.favIDs, "favIDs", ["foo3"]).having(
          (state) => state.restaurants,
          "restaurants",
          [restaurant.copyWith(isFavourite: true)],
        ),
      ],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'Can toggle restaurant off',
      build: () => RestaurantCubit(woltApiClient, geoLocationApiClient),
      seed: () => RestaurantState(
        restaurants: [restaurant.copyWith(isFavourite: true)],
        favIDs: const {"foo3"},
      ),
      act: (cubit) =>
          cubit.toggleFavourite(restaurant.copyWith(isFavourite: true)),
      expect: () => [
        isA<RestaurantState>()
            .having((state) => state.favIDs, "favIDs", []).having(
          (state) => state.restaurants,
          "restaurants",
          [restaurant.copyWith(isFavourite: false)],
        ),
      ],
    );
  });
}
