import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:test/test.dart';

import 'asset/wolt_restaurant_api_response.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenMeteoApiClient', () {
    late http.Client httpClient;
    late WoltApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = WoltApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(WoltApiClient(), isNotNull);
      });
    });

    group('getItems', () {
      const latitude = 60.170187;
      const longitude = 24.930599;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getItems(latitude: latitude, longitude: longitude);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('restaurant-api.wolt.com', 'v1/pages/restaurants', {
              'lat': '$latitude',
              'lon': '$longitude',
            }),
          ),
        ).called(1);
      });

      test('throws RestaurantRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getItems(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<RestaurantRequestFailure>()),
        );
      });

      test('throws RestaurantNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getItems(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<RestaurantNotFoundFailure>()),
        );
      });

      test('returns items on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(restaurantAPIResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getItems(
          latitude: latitude,
          longitude: longitude,
        );
        expect(actual.length, 1);

        final image = Image(
          blurhash: 'jjTYCHru;;DcT;qIh5plTaKBcPBk',
          url:
              'https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png',
        );
        final venue = Venue(
          id: '5ae6013cf78b5a000bb64022',
          name: 'McDonald\'s Helsinki Kamppi',
          location: [24.930145740509033, 60.16896328076366],
          shortDescription: 'I\'m lovin\' it.',
        );
        final item = Item(image: image, venue: venue);

        expect(actual.first, item);
      });
    });
  });
}
