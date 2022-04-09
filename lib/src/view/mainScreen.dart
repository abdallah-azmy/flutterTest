import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/provider/authenticationProvider.dart';
import 'package:fluttertest/src/view/appBottomNavBar.dart';
import 'package:fluttertest/src/view/myConversations.dart';
import 'package:fluttertest/src/view/otherUsers.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    print("building >>>>>>>>>>>>>>");
    return Scaffold(
      extendBody: true,
      floatingActionButton:
      Consumer<AuthProvider>(
        builder: (_,provider,__){
          return FloatingActionButton(
            onPressed: () {
              provider.signOut();
            },
            backgroundColor: const Color(0xffe51e4e),
            child: const Icon(Icons.logout_outlined),
          );
        },
      ),

      body: [
        const MyConversations(),
        const OtherUsers(),
      ][_bottomNavIndex],
      bottomNavigationBar: AppBottomBar(
        userType: "user",
        onTap: (v) {
          setState(() {
            _bottomNavIndex = v;
          });
        },
        index: _bottomNavIndex,
      ),
    );
  }
}
