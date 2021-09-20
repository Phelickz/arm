import 'dart:io';

import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class CreatePostViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  final RouterService _routerService = locator<RouterService>();

  Future navigateTo(dynamic object) async {
    await _routerService.router.push(
      object
    );
  }

  Future navigateToAndReplace(dynamic object) async {
    await _routerService.router.push(
      object
    );
  }

  XFile? _image;
  XFile? get image => _image;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> selectImage() async {
    try {
      setBusy(true);
      final ImagePicker _picker = ImagePicker();

      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _image = image;

        notifyListeners();
        setBusy(false);
      } else {
        await SnackBarAlerts.showToast('No image was selected');
        setBusy(false);
      }
    } on Exception catch (e) {
      await SnackBarAlerts.showToast('Action blocked');
    }
  }

  Future<String?> uploadImage(
      {required String title,
      required String description,
      required XFile file}) async {
    setBusy(true);
    File ufile = File(file.path);

    try {
      var task = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/${file.name}.png')
          .putFile(ufile);
      String url = await task.ref.getDownloadURL();

      if (url.isNotEmpty) {
        var doc1 = await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Posts').doc();

        var doc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Posts')
            .doc(doc1.id)
            .set({
          "title": title,
          "description": description,
          "image": url,
          "id": doc1.id,
          "createdAt": Timestamp.now()
        });

        setBusy(false);
        await SnackBarAlerts.showToast('Upload Successful');
        return doc1.id;
      } else {
        setBusy(false);
        return null;
      }
    } on firebase_storage.FirebaseException catch (e) {
      await SnackBarAlerts.showToast(e.message!);
      setBusy(false);
      return null;
    }
  }
}
