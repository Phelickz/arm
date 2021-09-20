import 'package:arm_test/app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';

class SnackBarAlerts {
  static showToast(String message) async {
    return OneContext().showSnackBar(
      builder: (context) => SnackBar(
        content: Text(message),
      ),
    );
  }
  // static showToast(String message) async {
  //   return Get.snackbar(
  //     '', '',
  //     snackbarStatus: (SnackbarStatus? status) {
  //       print(status);
  //     },
  //     // leftBarIndicatorColor: Colors.black,
  //     margin: EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
  //     duration: Duration(seconds: 5),
  //     // backgroundColor: Colors.,
  //     titleText: Text(
  //       'Failed to Process Request',
  //       style: CustomThemeData.generateStyle(
  //         fontSize: 14,
  //         color: Colors.white70,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //     messageText: Text(
  //       message,
  //       style: CustomThemeData.generateStyle(
  //         fontSize: 11,
  //         color: Colors.white70,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //     snackPosition: SnackPosition.BOTTOM,
  //     snackStyle: SnackStyle.FLOATING,
  //     shouldIconPulse: true,
  //     icon: Icon(
  //       Icons.info,
  //       color: Colors.white60,
  //     ),
  //     isDismissible: true,
  //     borderRadius: 8,
  //     mainButton: TextButton(
  //       onPressed: () async {
  //         if (Get.isSnackbarOpen!) {
  //           Get.back();
  //         }
  //       },
  //       child: Icon(
  //         Icons.close,
  //         color: Colors.white70,
  //       ),
  //     ),
  //   );
  // }
}
