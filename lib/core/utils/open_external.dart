import 'package:url_launcher/url_launcher.dart';

class OpenExternal {
  static Future<void> openMap(String location) async {
    // Android
    final url = 'geo:0,0?q=$location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // iOS
      final url = 'http://maps.apple.com/?q=$location';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw StateError('невозможно открыть $url');
      }
    }
  }
}
