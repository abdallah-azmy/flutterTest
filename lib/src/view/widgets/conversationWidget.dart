import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/helper/route.dart';
import 'package:fluttertest/src/model/conversationModel.dart';
import 'package:fluttertest/src/view/chat.dart';
import 'package:intl/intl.dart' as intl;

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({Key? key, required this.provider, this.index})
      : super(key: key);

  final int? index;
  final ConversationModel? provider;

  changeDateFormat(date) {
    String formattedDate = intl.DateFormat.yMd().add_jm().format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            Chat(
              mail: provider!.senderMail,
              name:  provider!.senderName,
              uid:  provider!.uid,
            ));
      },
      child: Container(
        height: 100,
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
                      Text(provider!.senderName!, style: MyTheme.styleBlackBold),
                    ],
                  ),
                  Text(provider!.senderMail!, style: MyTheme.styleHint0),
                  Text(provider!.messageText!, style: MyTheme.styleBlue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${ changeDateFormat(provider!.date!)}", style: MyTheme.styleRed),
                    ],
                  ),
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
