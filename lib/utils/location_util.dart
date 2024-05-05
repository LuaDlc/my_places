import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const googleApiKey = 'AIzaSyDdZYAOwv9FCUBdWdX2XGNJqHMwHeOXS7w';

class LocationUtil {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude,&key=$googleApiKey';
  }

  static Future<String> getAdressFrom(LatLng position) async {
    final url = '';
    final response = await http.get(url as Uri);
    return json.decode(response.body)['results'][0]['formatted_adress'];
  }
}
