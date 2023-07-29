import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_location/geo_location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

import '../../helpers/hydrated_bloc.dart';

class MockWoltApiClient extends Mock implements WoltApiClient {}

class MockGeoLocationApiClient extends Mock implements GeoLocationApiClient {}

class MockRestaurantCubit extends Mock implements RestaurantCubit {}

void main() {
  initHydratedStorage();

  group('RestaurantScreen', () {
    late WoltApiClient woltApiClient;
    late GeoLocationApiClient geoLocationApiClient;

    setUp(() {
      woltApiClient = MockWoltApiClient();
      geoLocationApiClient = MockGeoLocationApiClient();

      when(() => geoLocationApiClient.streamLatLong())
          .thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders RestaurantView', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<WoltApiClient>(
                create: (context) => woltApiClient),
            RepositoryProvider<GeoLocationApiClient>(
                create: (context) => geoLocationApiClient),
          ],
          child: const MaterialApp(
            home: RestaurantScreen(),
          ),
        ),
      );
      expect(find.byType(RestaurantView), findsOneWidget);
    });
  });

  group('RestaurantView', () {
    late RestaurantCubit restaurantCubit;

    setUp(() {
      restaurantCubit = MockRestaurantCubit();
      when(() => restaurantCubit.stream)
          .thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders Loading for RestaurantStatus.initial', (tester) async {
      when(() => restaurantCubit.state).thenReturn(RestaurantState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: restaurantCubit,
          child: const MaterialApp(home: RestaurantView()),
        ),
      );
      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders Loading for RestaurantStatus.Loading', (tester) async {
      when(() => restaurantCubit.state)
          .thenReturn(RestaurantState(status: RestaurantStatus.loading));
      await tester.pumpWidget(
        BlocProvider.value(
          value: restaurantCubit,
          child: const MaterialApp(home: RestaurantView()),
        ),
      );
      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders ListWidget for RestaurantStatus.Success',
        (tester) async {
      when(() => restaurantCubit.state).thenReturn(
          RestaurantState(status: RestaurantStatus.success, restaurants: []));
      await tester.pumpWidget(
        BlocProvider.value(
          value: restaurantCubit,
          child: const MaterialApp(home: RestaurantView()),
        ),
      );
      expect(find.byType(ListWidget), findsOneWidget);
    });

    testWidgets('renders FailureWidget for RestaurantStatus.Failure',
        (tester) async {
      when(() => restaurantCubit.state)
          .thenReturn(RestaurantState(status: RestaurantStatus.failure));
      await tester.pumpWidget(
        BlocProvider.value(
          value: restaurantCubit,
          child: const MaterialApp(home: RestaurantView()),
        ),
      );
      expect(find.byType(FailureWidget), findsOneWidget);
    });
  });
}
