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
  Rxn<String> selectedAccess = Rxn();

  TextEditingController email =
      TextEditingController(text: "admin@skillchain.com");
  TextEditingController password = TextEditingController(text: "123456");

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController verificationId = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print(Get.currentRoute);

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

  bool validate({bool isSignUp = false}) {
    if (isSignUp) {
      if (name.text.trim().isEmpty) {
        webToast("Please enter valid institute name!");
        return false;
      }
      if (address.text.trim().isEmpty) {
        webToast("Please enter valid address!");
        return false;
      }
      if (verificationId.text.trim().isEmpty) {
        webToast("Please enter valid verification id!");
        return false;
      }
      if (selectedAccess.value == null) {
        webToast("Please select one access!");
        return false;
      }
    }
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

  addInstitute() async {
    if (validate(isSignUp: true)) {
      LoadingManager.shared.showLoading();
      try {
        const url =
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyADVUZ9MmHJerZUtFdDss5kv9-0JJFg45g';

        // final response = await http.post(
        //   Uri.parse(url),
        //   body: json.encode(
        //     {
        //       'email': email,
        //       'password': password,
        //       'returnSecureToken': true,
        //     },
        //   ),
        // );
        // final responseData = json.decode(response.body);

        User? user = FirebaseAuth.instance.currentUser;
        print(user);
        // if (user != null) {
        //   await user.updateDisplayName(name.text);
        //   await user.reload();
        //   FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        //     "username": name.text,
        //     "uid": user.uid,
        //     "photo_url": user.photoURL,
        //     "likes": 0,
        //     "places": 0,
        //     "views": 0,
        //     "created_at": Timestamp.now(),
        //   });
        //   loggedInUser.value = FirebaseAuth.instance.currentUser;
        //   print(FirebaseAuth.instance.currentUser);
        // }

        Get.back();

        email.clear();
        password.clear();
        name.clear();
        verificationId.clear();
        address.clear();
        selectedAccess.value = null;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'weak-password') {
          webToast("The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          webToast("The account already exists for that email.");
        }
      } catch (e) {
        print(e);
      } finally {
        LoadingManager.shared.hideLoading();
      }
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.currentUser?.reload();
    Get.offAndToNamed(Screens.root);
  }
}
