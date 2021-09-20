import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future navigateTo(dynamic object) async {
    await _routerService.router.push(object);
  }

  Future<void> init() async {}

  Future<void> delete(String id) async {
    try {
      setBusy(true);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Posts')
          .doc(id)
          .delete();
      setBusy(false);
      navigateTo(HomeRoute());
    } on FirebaseException catch (e) {
      setBusy(false);
      SnackBarAlerts.showToast(e.message!);
    }
  }
}
