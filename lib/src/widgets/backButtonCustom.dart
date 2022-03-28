import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({Key? key, this.color, this.onPress,this.size}) : super(key: key);
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
          // FocusScope.of(context).requestFocus(FocusNode());
          // Navigator.of(context).pop();
        }
      },
      child: Icon(
        Icons.arrow_back,
        size: size ?? 28,
        color: color ?? Colors.white,
      ),
    );
  }
}
