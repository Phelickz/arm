import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future navigateTo(dynamic object) async {
    await _routerService.router.push(object);
  }

  Future<void> init() async {}

  Future<User?> login({required String email, required String password}) async {
    try {
      setBusy(true);
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      
      if(user.user != null) {
        setBusy(false);
        return user.user;
      }
    } on FirebaseAuthException catch (e) {
      await SnackBarAlerts.showToast(e.message!);
      setBusy(false);
      return null;
    } on FirebaseException catch (e) {
      await SnackBarAlerts.showToast(e.message!);
      setBusy(false);
      return null;
    } catch (e) {
      await SnackBarAlerts.showToast('An unknown error occurred');
      setBusy(false);
      return null;
    }
  }
}
