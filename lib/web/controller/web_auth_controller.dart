import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/loading_manager.dart';
import '../utils/ui_element.dart';
import '../utils/web_support.dart';

class WebAuthController extends GetxController {
  RxBool isLoggedIn = RxBool(false);
  Rxn<Uint8List> selectedImages = Rxn<Uint8List>();
  Rxn<User> loggedInUser = Rxn();

  TextEditingController email =
      TextEditingController(text: "admin@skillchain.com");
  TextEditingController password = TextEditingController(text: "123456");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user);
      loggedInUser.value = user;
      isLoggedIn.value = user != null;
    });
  }

  pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      selectedImages.value = result.files.first.bytes;
      selectedImages.refresh();
      // updateProfile();
    } else {}
  }

  updateProfile() async {
    try {
      LoadingManager.shared.showLoading();
      User? user = FirebaseAuth.instance.currentUser;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user_profile/${user?.uid}.png');

      UploadTask uploadTask = storageReference.putData(selectedImages.value!);

      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        print('Image URL: $imageUrl');
        await user?.updatePhotoURL(imageUrl);
        await user?.reload();
        FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
          "photo_url": imageUrl,
        });
        loggedInUser.value = FirebaseAuth.instance.currentUser;
      });
    } catch (e) {
      webToast("Something went wrong!");
      print('Error uploading image: $e');
    } finally {
      LoadingManager.shared.hideLoading();
    }
  }

  bool validate() {
    hideKeyboard();
    if (!email.text.trim().isEmail) {
      webToast("Please enter valid emailId!");
      return false;
    }
    if (password.text.trim().length < 6) {
      webToast("Password should be about 6 characters!");
      return false;
    }
    return true;
  }

  login() async {
    if (validate()) {
      LoadingManager.shared.showLoading();
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        await FirebaseAuth.instance.currentUser?.reload();
        loggedInUser.value = FirebaseAuth.instance.currentUser;
        print(credential);
        email.clear();
        password.clear();
        Get.offAndToNamed(Screens.dashboard);
        setWebTitleAndUrl("Login", "");
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'user-not-found' || e.code == "invalid-credential") {
          webToast("No user found for that email.");
        } else if (e.code == 'wrong-password') {
          webToast("Wrong password provided for that user.");
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          webToast("Invalid login credentials.");
        }
      } catch (e) {
        print(e);
      } finally {
        LoadingManager.shared.hideLoading();
      }
    }
  }

  // signUp() async {
  //   if (validate(withName: true)) {
  //     LoadingManager.shared.showLoading();
  //     try {
  //       final credential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailId.text,
  //         password: password.text,
  //       );
  //       User? user = FirebaseAuth.instance.currentUser;
  //       if (user != null) {
  //         await user.updateDisplayName(name.text);
  //         await user.reload();
  //         FirebaseFirestore.instance.collection("users").doc(user.uid).set({
  //           "username": name.text,
  //           "uid": user.uid,
  //           "photo_url": user.photoURL,
  //           "likes": 0,
  //           "places": 0,
  //           "views": 0,
  //           "created_at": Timestamp.now(),
  //         });
  //         loggedInUser.value = FirebaseAuth.instance.currentUser;
  //         print(FirebaseAuth.instance.currentUser);
  //       }
  //
  //       Get.back();
  //
  //       emailId.controller.clear();
  //       password.controller.clear();
  //       name.controller.clear();
  //     } on FirebaseAuthException catch (e) {
  //       print(e.code);
  //       if (e.code == 'weak-password') {
  //         ToastManager.shared.show("The password provided is too weak.");
  //       } else if (e.code == 'email-already-in-use') {
  //         ToastManager.shared
  //             .show("The account already exists for that email.");
  //       }
  //     } catch (e) {
  //       print(e);
  //     } finally {
  //       LoadingManager.shared.hideLoading();
  //     }
  //   }
  // }

  logout() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.currentUser?.reload();
    Get.offAndToNamed(Screens.root);
  }
}
