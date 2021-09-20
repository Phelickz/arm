import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/services/router_service.dart';

class StartupViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future<void> init() async {
    WidgetsBinding.instance!.addPostFrameCallback((Duration duration) async {
      await navigateToHomeView();
    });
  }

  Future navigateToHomeView() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await _routerService.router.push(
        SignUpRoute(),
      );
    } else {
      await _routerService.router.push(
        HomeRoute(),
      );
    }
  }
}
