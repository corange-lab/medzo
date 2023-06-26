import 'package:get/get.dart';
import 'package:medzo/utils/string.dart';

abstract class GetConnectImpl extends GetConnect {
  GetConnectImpl()
      : super(
            timeout: const Duration(seconds: ConstString.timeOutTimeInSeconds));

  void printApiLog(String url, Response<dynamic> response) {
    //ignore: avoid_print
    print('API Call ${toString()} ${runtimeType.hashCode} $url');
    //ignore: avoid_print
    print('API Call ${runtimeType.hashCode} ${response.bodyString}');
  }
}
