import 'package:test/test.dart';
import 'package:wolt_api/wolt_api.dart';

void main() {
  group('Venue', () {
    group('fromJson', () {
      test('returns correct Venue object', () {
        final latLon = [24.930145740509033, 60.16896328076366];
        expect(
          Venue.fromJson(
            <String, dynamic>{
              'id': '5ae6013cf78b5a000bb64022',
              'name': 'McDonald\'s Helsinki Kamppi',
              'location': latLon,
              'short_description': 'I\'m lovin\' it.'
            },
          ),
          isA<Venue>()
              .having((i) => i.id, 'id', '5ae6013cf78b5a000bb64022')
              .having((i) => i.name, 'name', 'McDonald\'s Helsinki Kamppi')
              .having((i) => i.location, 'location', latLon)
              .having((i) => i.shortDescription, 'shor_description',
                  'I\'m lovin\' it.'),
        );
      });
    });
  });
}
