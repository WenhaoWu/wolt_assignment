import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wolt_api/src/models/models.dart';

/// Exception thrown when getItem fails.
class RestaurantRequestFailure implements Exception {}

/// Exception thrown when restaurant for provided location is not found.
class RestaurantNotFoundFailure implements Exception {}

/// {@template wolt_api_client}
/// Dart API Client which wraps the [Wolt API](https://restaurant-api.wolt.com).
/// {@endtemplate}
class WoltApiClient {
  /// {@macro wolt_api_client}
  WoltApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlRestaurant = 'restaurant-api.wolt.com';

  static const sectionRestaurantsDeliveringVenues =
      "restaurants-delivering-venues";

  final http.Client _httpClient;

  /// Fetches [Weather] for a given [latitude] and [longitude].
  Future<List<Item>> getItems({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.https(
      _baseUrlRestaurant,
      'v1/pages/restaurants',
      {'lat': '$latitude', 'lon': '$longitude'},
    );

    final response = await _httpClient.get(weatherRequest);

    if (response.statusCode != 200) {
      throw RestaurantRequestFailure();
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('sections')) {
      throw RestaurantNotFoundFailure();
    }

    final sectionsJson = bodyJson['sections'] as List<dynamic>;

    final restaurantSection = sectionsJson.firstWhere(
      (section) => section["name"] == sectionRestaurantsDeliveringVenues,
      orElse: () => throw RestaurantNotFoundFailure(),
    );

    final itemsJson = restaurantSection['items'] as List<dynamic>;

    return itemsJson.map((itemJson) => Item.fromJson(itemJson)).toList();
  }
}
