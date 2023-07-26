import 'package:geo_location/geo_location.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    // Additional setup goes here.
  });

  test('Geo location stream test', () async {
    final stream = GeoLocationApiClient().streamLatLong(
      duration: Duration(milliseconds: 10),
    );

    int i = 0;

    final sub = stream.listen(expectAsync1((event) {
      final index = i % 10;
      final latLong = LatLong(mockData[index].first, mockData[index].last);
      expect(event, latLong);
      i++;
    }, max: -1));

    await Future.delayed(Duration(seconds: 2), () => sub.cancel());

    expect(i, 200); // 2 seconds / 10 milliseconds
  });
}
