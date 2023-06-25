// import 'dart:developer';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
// import 'package:medzo/utils/string.dart';
// import 'package:medzo/utils/utils.dart';

class NetworkHandlingService extends GetxService {
  // bool _isFirstTime = true;
  //
  // final Connectivity _connectivity = Connectivity();
  // static final _connectionStatus =
  //     Rx<ConnectivityResult>(ConnectivityResult.none);
  // static ConnectivityResult get connectionStatus => _connectionStatus.value;

  @override
  void onInit() {
    // _connectivity.checkConnectivity().then((value) {
    //   if (value == ConnectivityResult.none ||
    //       value == ConnectivityResult.bluetooth) {
    //     _isFirstTime = false;
    //     _notifyConnectionStatus(value);
    //   }
    // });
    // _connectivity.onConnectivityChanged.listen(_notifyConnectionStatus);
    super.onInit();
  }

  // Future<void> _notifyConnectionStatus(ConnectivityResult status) async {
  //   log('Network status $status $_isFirstTime');
  //   if (status == ConnectivityResult.mobile ||
  //       status == ConnectivityResult.wifi) {
  //     if (_isFirstTime) {
  //       _isFirstTime = false;
  //     } else {
  //       if (!Platform.isIOS) {
  //         Get.closeCurrentSnackbar();
  //         showInSnackBar(ConstString.internetReestablished,
  //             duration: const Duration(seconds: 2), isSuccess: true);
  //       }
  //     }
  //   } else {
  //     if (!_isFirstTime) {
  //       showInSnackBar(ConstString.internetLost,
  //           duration: const Duration(minutes: 1));
  //     }
  //   }
  // }
  //
  // static bool isInternetAvailable() {
  //   if (connectionStatus == ConnectivityResult.mobile ||
  //       connectionStatus == ConnectivityResult.wifi) {
  //     return true;
  //   } else {
  //     showInSnackBar(ConstString.internetLost);
  //     return false;
  //   }
  // }
}
