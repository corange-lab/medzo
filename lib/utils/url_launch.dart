import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchWebUrl(String _url) async {
  if (!await launchUrlString(_url)) {
    throw Exception('Could not launch $_url');
  }
}
