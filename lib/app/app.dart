import 'package:arm_test/app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';

class ArmTestApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final RouterService _routerService = locator<RouterService>();

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('App could not load'),
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp.router(
            builder: OneContext().builder,
            debugShowCheckedModeBanner: false,
            title: "ArmPensions",
            routeInformationParser: _routerService.router.defaultRouteParser(),
            routerDelegate: _routerService.router.delegate(),
            theme: CustomThemeData.lightTheme,
            darkTheme: CustomThemeData.lightTheme,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
