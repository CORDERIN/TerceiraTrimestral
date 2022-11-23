import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class LocationService {
  final String key = 'AIzaSyBWePVEWvymT2II6Hbm5I5GVfd_86mKnEY';

  Future<String> getPlaceId(String name) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$name&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return results;
  }
}