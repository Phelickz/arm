import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future navigateTo(dynamic object) async {
    await _routerService.router.push(object);
  }

  Future<void> init() async {}

  Future<User?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      setBusy(true);
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      assert(user.user != null);
      if (user.user != null) {
        await user.user!.updateDisplayName('$firstName $lastName');
        await user.user!.reload();

        await FirebaseFirestore.instance.collection('Users').doc(user.user!.uid).set({
          "Email": email,
          "firstName": firstName,
          "lastName": lastName
        });
        setBusy(false);

        return user.user;
      }
    } on FirebaseAuthException catch (e) {
      await SnackBarAlerts.showToast(e.message!);
      setBusy(false);
      return null;
    } on FirebaseException catch(e) {
      await SnackBarAlerts.showToast(e.message!);
      setBusy(false);
      return null;
    } catch (e) {
      await SnackBarAlerts.showToast('An Unknown error occurred');
      setBusy(false);
      return null;
    }
  }
}
