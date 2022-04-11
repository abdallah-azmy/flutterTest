import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';

// ignore: must_be_immutable
class AppBottomBar extends StatefulWidget {
  final Function? onTap;
  final String? userType;
  int? index;

  AppBottomBar({Key? key, this.onTap, this.userType, this.index})
      : super(key: key);
  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 0.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: MyTheme.black,
            fontFamily: "IBM Plex Arabic",
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: MyTheme.grey,
            fontFamily: "IBM Plex Arabic",
          ),
          selectedItemColor: MyTheme.black,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: widget.index!,
          onTap: (index) {
            setState(() {
              widget.index = index;
            });
            widget.onTap!(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: "المحادثات",
              icon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              label: "المستخدمين",
              icon: Icon(Icons.person),
            ),
          ]),
    );
  }
}
