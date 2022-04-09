import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';

class SpecialButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? paddingHorizontal;
  final Color? textColor;
  final Widget? icon;
  final bool? buttonLikeTextField;
  final double? radius;
  final Color? iconBackColor;
  final double? width;
  final double? height;
  final double? textSize;

  final Function? onTap;

  const SpecialButton(
      {Key? key,
      this.text,
      this.textSize,
      this.paddingHorizontal,
      this.iconBackColor,
      this.radius,
      this.buttonLikeTextField,
      this.width,
      this.onTap,
      this.color,
      this.textColor,
      this.icon,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          height: height ?? 45,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 10),
              color: color ?? MyTheme.blue),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal ?? 20.0,
              ),
              child: Row(
                mainAxisAlignment: buttonLikeTextField == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor:
                                iconBackColor ?? Colors.transparent,
                            radius: 12,
                            child: icon,
                          ),
                        )
                      : Container(),
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 14,
                        fontFamily: "IBM Plex Arabic",
                        fontWeight: FontWeight.w700),
                  ),
                  icon != null
                      ? const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 12,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
