import 'package:test/test.dart';
import 'package:wolt_api/wolt_api.dart';

void main() {
  group('Item', () {
    group('fromJson', () {
      test('returns correct Item object', () {
        final latLon = [24.930145740509033, 60.16896328076366];
        final image = Image(blurhash: 'foo', url: 'bar');
        final venue = Venue(
          id: '5ae6013cf78b5a000bb64022',
          name: 'McDonald\'s Helsinki Kamppi',
          location: latLon,
          shortDescription: 'I\'m lovin\' it.',
        );

        expect(
          Item.fromJson(
            <String, dynamic>{
              'image': {'blurhash': 'foo', 'url': 'bar'},
              'venue': {
                'id': '5ae6013cf78b5a000bb64022',
                'name': 'McDonald\'s Helsinki Kamppi',
                'location': latLon,
                'short_description': 'I\'m lovin\' it.'
              }
            },
          ),
          isA<Item>()
              .having((i) => i.image, 'image', image)
              .having((i) => i.venue, 'venue', venue),
        );
      });
    });
  });
}
