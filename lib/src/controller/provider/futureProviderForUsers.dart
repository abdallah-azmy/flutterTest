import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/src/model/userModel.dart';

class UsersFutureProvider {
  List<UserModel> users = [];
  UsersFutureProvider();

  UsersFutureProvider.fromMap(
      QuerySnapshot<Map<String, dynamic>> usersSnapShots) {
    for (var doc in usersSnapShots.docs) {
      users.add(UserModel.fromMap(doc.data()));
    }
  }
}

//Fetching  conversations
Future<UsersFutureProvider>? getAllUsers() {
  print('---------------------started to get users');
  var result = FirebaseFirestore.instance
      .collection("users")
      .orderBy('date', descending: true)
      .get()
      .then((value) => UsersFutureProvider.fromMap(value));

  return result;
}
