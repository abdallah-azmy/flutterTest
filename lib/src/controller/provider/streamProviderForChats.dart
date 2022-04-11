import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/model/messageModel.dart';
import 'package:fluttertest/src/view/widgets/messageBubble.dart';

class ChatsProvider {
  List<MessageModel> messages = [];

  ChatsProvider();

  // ChatsProvider.fromMap(QuerySnapshot<Map<String, dynamic>> usersSnapShots) {

  ChatsProvider.fromMap(
        QuerySnapshot<Map<String, dynamic>> usersSnapShots) {
      for (var doc in usersSnapShots.docs) {
        messages.add(MessageModel.fromMap(doc.data()));
      }
    }

    // for (var message in usersSnapShots.docs) {
    //   final messageText = message.get("messageText");
    //   final senderMail = message.get("senderMail");
    //   final date = message.get("date").toDate();
    //   final currentUser = userData!.email;
    //
    //   final messageBubble = MessageBubble(
    //     date: date,
    //     sender: senderMail,
    //     text: messageText,
    //     isMe: currentUser == senderMail,
    //   );
    //
    //   messageBubbles.add(messageBubble);
    //
    // }
  // }
}

UserData? userData = Boxes.getUserData().get("me");

//Fetching  chats
Stream<ChatsProvider>? getChats({friendMail}) {
  print('---------------------started to get chats');
  return FirebaseFirestore.instance
      .collection("users")
      .doc(userData!.uid)
      .collection("userConversations")
      .doc(friendMail!)
      .collection("messages")
      .orderBy('date', descending: true)
      .snapshots()
      .map((conversations) => ChatsProvider.fromMap(conversations));
}
