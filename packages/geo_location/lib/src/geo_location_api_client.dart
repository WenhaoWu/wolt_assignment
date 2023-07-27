import 'package:geo_location/src/model/lat_long.dart';

const int refreshInterval = 10; // In seconds

const mockData = [
  [60.170187, 24.930599],
  [60.169418, 24.931618],
  [60.169818, 24.932906],
  [60.170005, 24.935105],
  [60.169108, 24.936210],
  [60.168355, 24.934869],
  [60.167560, 24.932562],
  [60.168254, 24.931532],
  [60.169012, 24.930341],
  [60.170085, 24.929569],
];

/// {@template geo_location_api_client}
/// Dart API Client which returns geo location in coordinates.
/// {@endtemplate}
class GeoLocationApiClient {
  Stream<LatLong> streamLatLong({
    Duration duration = const Duration(seconds: refreshInterval),
  }) {
    final listOfLatLon = <LatLong>[];
    for (var i = 0; i < 10; i++) {
      final item = LatLong(mockData[i].first, mockData[i].last);
      listOfLatLon.add(item);
    }

    return Stream.periodic(
      duration,
      (count) => listOfLatLon[count % 10],
    );
  }
}
