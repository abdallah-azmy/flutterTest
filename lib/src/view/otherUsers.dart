import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/boxes.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/provider/futureProviderForUsers.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/view/widgets/userWidget.dart';
import 'package:provider/provider.dart';

class OtherUsers extends StatefulWidget {
  const OtherUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<OtherUsers> createState() => _OtherUsersState();
}

class _OtherUsersState extends State<OtherUsers> {
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
        Container(
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
            children: const [
              SizedBox(
                height: 5,
              ),
              UsersStream()
            ],
          ),
        )
      ],
    );
  }
}

class UsersStream extends StatelessWidget {
  const UsersStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usersList = context.watch<UsersFutureProvider>().users;

    return usersList.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: const Center(
              child: Text(
                "لا يوجد مستخدمين",
                style: MyTheme.styleBlack1,
              ),
            ),
          )
        : ListView.builder(
            itemCount: usersList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              return UserWidget(
                provider: usersList[i],
                index: i,
              );
            });
  }
}
