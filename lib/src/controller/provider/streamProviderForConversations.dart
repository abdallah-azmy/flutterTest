import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/model/conversationModel.dart';
import 'package:fluttertest/src/model/hiveModel.dart';

class ConversationsProvider {
  List<ConversationModel> conversations = [];
  ConversationsProvider();

  ConversationsProvider.fromMap(
      QuerySnapshot<Map<String, dynamic>> usersSnapShots) {
    for (var doc in usersSnapShots.docs) {
      conversations.add(ConversationModel.fromMap(doc.data()));
    }
  }
}

UserData? userData = Boxes.getUserData().get("me");

//Fetching  conversations
Stream<ConversationsProvider> getConversations() {
  print('---------------------started to get conversations');
  return FirebaseFirestore.instance
      .collection("users")
      .doc(userData!.uid)
      .collection("userConversations")
      .snapshots()
      .map((conversations) => ConversationsProvider.fromMap(conversations));
}
