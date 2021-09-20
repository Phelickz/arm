import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class CustomBaseViewModel extends BaseViewModel {
  late Dio _dio;
  Dio get dio => _dio;

  static BaseOptions options = BaseOptions(
    baseUrl: Constants.NEWS_URL,
    // connectTimeout: 10000,
    receiveTimeout: 3000,
  );

  CustomBaseViewModel() {
    try {
      _dio = Dio(options);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
      } else {
        print(e.message);
      }
    }
  }
  final RouterService _routerService = locator<RouterService>();

  void goBack() {
    _routerService.router.pop();
  }

  void removeFocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
