import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/src/model/hiveModel.dart';

class DataProvider with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getConversations(UserData? _userDate) {
    Stream<QuerySnapshot<Object?>> _conversations = _fireStore
        .collection("users")
        .doc(_userDate!.uid)
        .collection("userConversations")
        .orderBy('date', descending: true)
        .snapshots();
    return _conversations;
  }

  Stream<QuerySnapshot<Object?>> getUsers() {
    Stream<QuerySnapshot<Object?>> _users = _fireStore
        .collection("users")
        .orderBy('date', descending: true)
        .snapshots();

    return _users;
  }

  Stream<QuerySnapshot<Object?>> getChats(
      {UserData? userData, String? friendMail}) {
    Stream<QuerySnapshot<Object?>> _users = _fireStore
        .collection("users")
        .doc(userData!.uid)
        .collection("userConversations")
        .doc(friendMail!)
        .collection("messages")
        .orderBy('date', descending: true)
        .snapshots();

    return _users;
  }
}
