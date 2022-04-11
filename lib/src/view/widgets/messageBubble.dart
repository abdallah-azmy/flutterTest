import 'package:flutter/material.dart';
import 'package:fluttertest/src/model/userModel.dart';
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
