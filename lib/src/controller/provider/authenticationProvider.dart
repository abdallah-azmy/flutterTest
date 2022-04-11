import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/main.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/controller/helper/route.dart';
import 'package:fluttertest/src/controller/helper/toast.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/model/userModel.dart';
import 'package:fluttertest/src/view/authintication/logInScreen.dart';
import 'package:fluttertest/src/view/mainScreen.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  bool loading = false;
  String? name;
  UserModel? _user;
  String? email;
  String? password;

  bool get getLoader => loading;

  logIn() async {
    loading = true;
    notifyListeners();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          await _auth
              .signInWithEmailAndPassword(
            email: email!,
            password: password!,
          )
              .then((v) async {
            ///////////// store user's data in Hive ///////////////
            if (v.user!.email != null) {
              DocumentSnapshot _documentSnapshot =
                  await _fireStore.collection('users').doc(v.user!.uid).get();

              final savedModel = UserData()
                ..name = _documentSnapshot.get("name")!
                ..email = _documentSnapshot.get("email")!
                ..uid = _documentSnapshot.get("uid")!
                ..date = _documentSnapshot.get("date").toDate();

              final box = Boxes.getUserData();
              box.put("me", savedModel);
              ////////////////////////////////////////////////////////

              loading = false;
              notifyListeners();
              pushAndRemoveUntil(navigator.currentContext!, const MainScreen());
            }
          });
        } catch (e) {
          loading = false;
          notifyListeners();
          showToast(
              msg: "لقد حدث خطأ في اتمام العملية !", state: ToastStates.error);
        }
      }
    } on SocketException catch (_) {
      loading = false;
      notifyListeners();
      showToast(
          msg: "لا يوجد اتصال بشبكة الانترنت !", state: ToastStates.error);
    }
  }

  signUp() async {
    loading = true;
    notifyListeners();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          await _auth
              .createUserWithEmailAndPassword(
                  email: email!, password: password!)
              .then((v) async {
            ///////////// store user's data in firebase ///////////////
            DateTime now = DateTime.now();
            _user = UserModel(
              uid: v.user!.uid,
              email: v.user!.email,
              name: name!,
              date: now,
            );
            await _fireStore
                .collection('users')
                .doc(_user!.uid)
                .set(_user!.toMap(_user!))
                .then((_) {
              ///////////// store user's data in Hive ///////////////

              final savedModel = UserData()
                ..name = name!
                ..email = v.user!.email!
                ..uid = v.user!.uid
                ..date = now;

              final box = Boxes.getUserData();
              box.put("me", savedModel);
              ////////////////////////////////////////////////////////

              loading = false;
              notifyListeners();
              pushAndRemoveUntil(navigator.currentContext!, const MainScreen());
            });
          });
        } catch (e) {
          loading = false;
          notifyListeners();
          showToast(
              msg: "لقد حدث خطأ في اتمام العملية !", state: ToastStates.error);
        }
      }
    } on SocketException catch (_) {
      loading = false;
      notifyListeners();
      showToast(
          msg: "لا يوجد اتصال بشبكة الانترنت !", state: ToastStates.error);
    }
  }

  signOut() {
    _auth.signOut().then((_) {
      final box = Boxes.getUserData();
      box.deleteAt(0);
      push(navigator.currentContext!, const LogInScreen());
    });
  }
}
