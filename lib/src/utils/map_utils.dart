import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude,
      String destinationLatitude, String destinationLongitude) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$latitude,$longitude&destination=$destinationLatitude,$destinationLongitude';
    print(googleUrl);
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
