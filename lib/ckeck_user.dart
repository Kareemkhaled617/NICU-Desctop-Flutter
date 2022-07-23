import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

class UtilityService{

  Timer? timer;
  var logger = Logger();
  bool isOnline = true;

  Future checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        logger.i("Connected Online");
        logger.i(isOnline);
        isOnline = true;
      }
    } on SocketException catch (_) {
      logger.e("Offline !!!");
      isOnline = false;
    }
    return isOnline;
  }

}