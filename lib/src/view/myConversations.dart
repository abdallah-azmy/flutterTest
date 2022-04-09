import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/helper/route.dart';
import 'package:fluttertest/src/controller/provider/dataProvider.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/model/messageModel.dart';
import 'package:fluttertest/src/model/userModel.dart';
import 'package:fluttertest/src/view/authintication/logInScreen.dart';
import 'package:fluttertest/src/view/widgets/conversationWidget.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class MyConversations extends StatefulWidget {
  const MyConversations({
    Key? key,
  }) : super(key: key);

  @override
  State<MyConversations> createState() => _MyConversationsState();
}

class _MyConversationsState extends State<MyConversations> {
  UserData? userData = Boxes.getUserData().get("me");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          color: MyTheme.black,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    userData == null ? "" : userData!.name,
                    style: MyTheme.styleWhite1,
                  ),
                  Text(
                    userData == null ? "" : userData!.email,
                    style: MyTheme.styleWhite1,
                  ),
                ],
              ),
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          // stream: Provider.of<UsersProvider>(context).getConversations(userData),
          stream: _fireStore
              .collection("users")
              .doc(userData!.uid)
              .collection("userConversations")
              // .doc(friendMail!)
              // .collection("messages")
              // .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                margin: const EdgeInsetsDirectional.only(top: 100),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    // color: MyTheme.backGround,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.white,
                        Color(0xfff9fafc),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.black,
                  ),
                ),
              );
            }

            print("0000000000000000000000000");
            final users = snapshot.data!.docs;
            print("1111111111111111111111111 ${users.toString()}");

            List<MessageModel> conversationsList = [];
            if (users.isNotEmpty) {
              print("222222222222222222222222222 $users");
              for (var user in users) {
                final singleMessage = MessageModel(
                    messageText: user.get("messageText"),
                    senderName: user.get("senderName"),
                    uid: user.get("uid"),
                    date: user.get("date")!.toDate!(),
                    senderMail: user.get("senderMail"));

                if (user.get("senderMail") != userData!.email) {
                  conversationsList.add(singleMessage);
                }
              }
            }

            return Container(
              margin: const EdgeInsetsDirectional.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  // color: MyTheme.backGround,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Color(0xfff9fafc),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  conversationsList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .7,
                          child: const Center(
                            child: Text(
                              "لا توجد محادثات",
                              style: MyTheme.styleBlack1,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: conversationsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, i) {
                            return ConversationWidget(
                              provider: conversationsList[i],
                              index: i,
                            );
                          })
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
