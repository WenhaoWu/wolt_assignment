import 'package:test/test.dart';
import 'package:wolt_api/wolt_api.dart';

void main() {
  group('Image', () {
    group('fromJson', () {
      test('returns correct Image object', () {
        expect(
            Image.fromJson(
              <String, dynamic>{
                'blurhash': 'jjTYCHru;;DcT;qIh5plTaKBcPBk',
                'url':
                    'https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png',
              },
            ),
            isA<Image>()
                .having((i) => i.blurhash, 'blurhash',
                    'jjTYCHru;;DcT;qIh5plTaKBcPBk')
                .having((i) => i.url, 'url',
                    'https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png'));
      });
    });
  });
}
