import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/provider/dataProvider.dart';
import 'package:fluttertest/src/model/friendModel.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/model/messageModel.dart';
import 'package:fluttertest/src/model/userModel.dart';
import 'package:fluttertest/src/view/widgets/specialButton.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class Chat extends StatefulWidget {
  const Chat({this.name, this.uid, this.mail, Key? key}) : super(key: key);

  final String? name;
  final String? mail;
  final String? uid;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  UserData? userData = Boxes.getUserData().get("me");

  String? messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name!),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MessagesStream(friendMail: widget.mail, userData: userData),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.only(top: 7),
                          padding: const EdgeInsets.only(bottom: 5, left: 7),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(top: 14, left: 16),
                              hintText: 'اكتب هنا',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            controller: messageController,
                            onChanged: (value) {
                              messageText = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SpecialButton(
                            paddingHorizontal: 7.0,
                            radius: 30.0,
                            color: MyTheme.black,
                            onTap: () {
                              if (messageController.text != "") {
                                //////////////////  save conversation info in my data ///////////////
                                var now = DateTime.now();
                                FriendModel? _forMe = FriendModel(
                                  uid: widget.uid,
                                  friendMail: widget.mail,
                                  friendName: widget.name,
                                  messageText: messageText,
                                  date: now,
                                );

                                _fireStore
                                    .collection('users')
                                    .doc(userData!.uid)
                                    .collection('userConversations')
                                    .doc(widget.mail)
                                    .set(_forMe.toMap(_forMe));

                                //////////////////  save messages of conversation in my data ///////////////

                                MessageModel? messageModel = MessageModel(
                                  messageText: messageText,
                                  senderMail: userData!.email,
                                  senderName: userData!.name,
                                  uid: userData!.uid,
                                  date: now,
                                );
                                _fireStore
                                    .collection("users")
                                    .doc(userData!.uid)
                                    .collection("userConversations")
                                    .doc(widget.mail)
                                    .collection("messages")
                                    .doc(now.toString())
                                    .set(messageModel.toMap(messageModel));

                                //////////////////  save conversation info in friend's data ///////////////

                                FriendModel? _forFriend = FriendModel(
                                  uid: userData!.uid,
                                  friendMail: userData!.email,
                                  friendName: userData!.name,
                                  messageText: messageText,
                                  date: now,
                                );
                                _fireStore
                                    .collection('users')
                                    .doc(widget.uid)
                                    .collection('userConversations')
                                    .doc(userData!.email)
                                    .set(_forFriend.toMap(_forFriend));

                                //////////////////  save messages of conversation in friend's data ///////////////
                                _fireStore
                                    .collection("users")
                                    .doc(widget.uid)
                                    .collection("userConversations")
                                    .doc(userData!.email)
                                    .collection("messages")
                                    .doc(now.toString())
                                    .set(messageModel.toMap(messageModel));

                                messageController.clear();
                              }
                            },
                            text: "Send",
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, this.friendMail, this.userData})
      : super(key: key);
  final String? friendMail;
  final UserData? userData;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Provider.of<DataProvider>(context)
            .getChats(userData: userData, friendMail: friendMail),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red[900],
                ),
              ),
            );
          }
          final messages = snapshot.data!.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.get("messageText");
            final senderMail = message.get("senderMail");
            final date = message.get("date").toDate();
            final currentUser = userData!.email;

            final messageBubble = MessageBubble(
              date: date,
              sender: senderMail,
              text: messageText,
              isMe: currentUser == senderMail,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatefulWidget {
  const MessageBubble({Key? key, this.sender, this.text, this.isMe, this.date})
      : super(key: key);

  final String? sender;
  final DateTime? date;
  final String? text;
  final bool? isMe;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  UserModel? user;

  changeDateFormat() {
    String formattedDate = intl.DateFormat.yMd().add_jm().format(widget.date!);
    return formattedDate;
  }

  //
  //
  // Future<UserModel> getSenderData() async {
  //   var _querySnapshot = await _fireStore
  //       .collection("users")
  //       .where("email", isEqualTo: widget.sender)
  //       .get();
  //
  //   return UserModel.fromMap(_querySnapshot.docs[0].data());
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            widget.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.sender!,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(
            height: 2,
          ),
          Material(
            borderRadius: widget.isMe!
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
            elevation: 5,
            color: widget.isMe! ? Colors.blue : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding: widget.isMe!
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(right: 10),
                child: Text(
                  widget.text!,
                  style: TextStyle(
                      fontSize: 15,
                      color: widget.isMe! ? Colors.white : Colors.black87),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
