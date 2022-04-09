import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/helper/route.dart';
import 'package:fluttertest/src/model/userModel.dart';
import 'package:fluttertest/src/view/chat.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key, required this.provider, this.index})
      : super(key: key);

  final int? index;
  final UserModel? provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            Chat(
              name: provider!.name,
              mail: provider!.email,
              uid: provider!.uid,
            ));
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: MyTheme.grey.withOpacity(.05),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(provider!.name!, style: MyTheme.styleHint),
                    ],
                  ),
                  Text(provider!.email!, style: MyTheme.styleBlue),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
