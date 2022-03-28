import 'package:flutter/material.dart';

class AddButtonCustom extends StatelessWidget {
  const AddButtonCustom({Key? key, this.color, this.onPress,this.size}) : super(key: key);
  final Color? color;
  final double? size;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPress != null) {
          onPress;
        } else {
          print("pressed !");
        }
      },
      child: Icon(
        Icons.add,
        size: size ?? 28,
        color: color ?? Colors.white,
      ),
    );
  }
}
