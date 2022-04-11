import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/provider/streamProviderForChats.dart';
import 'package:fluttertest/src/model/friendModel.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/model/messageModel.dart';
import 'package:fluttertest/src/view/widgets/messageBubble.dart';
import 'package:fluttertest/src/view/widgets/specialButton.dart';
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamProvider(
                    initialData: ChatsProvider(),
                    create: (context) => getChats(friendMail: widget.mail),
                    child: const MessagesStream()),
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
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MessageModel> message = context.watch<ChatsProvider>().messages;
    return Expanded(
      child: message.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red[900],
                ),
              ),
            )
          : ListView.builder(
              reverse: true,
              itemCount: message.length,
              itemBuilder: (context, index) => MessageBubble(
                date: message[index].date,
                text: message[index].messageText,
                sender: message[index].senderMail,
                isMe: userData!.email == message[index].senderMail,
              ),
            ),
    );
  }
}
