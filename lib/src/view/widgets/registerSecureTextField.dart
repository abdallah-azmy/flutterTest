
import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';

class RegisterSecureTextField extends StatefulWidget {
  final String? label;
  final IconData? icon;

  final String? errorText;
  final double? radius;
  final Widget? preIcon;
  final Color? color;
  final double? contentPaddingVertically;
  final String? hint;
  final Function? onChange;
  final Function? error;

  const RegisterSecureTextField(
      {Key? key,
      this.label,
      this.hint,
      this.contentPaddingVertically,
      this.errorText,
      this.onChange,
      this.radius,
      this.color,
      this.icon,
      this.preIcon,
      this.error})
      : super(key: key);

  @override
  _RegisterSecureTextFieldState createState() =>
      _RegisterSecureTextFieldState();
}

class _RegisterSecureTextFieldState extends State<RegisterSecureTextField> {
  bool see = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onChanged: (v){
          widget.onChange!(v);
        },
        obscureText: see,
        validator: (value) {
          if (value!.isEmpty) {
            return "${widget.hint ?? widget.label} مطلوبة";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint ?? "",
          hintStyle:const TextStyle(fontWeight: FontWeight.normal ,fontFamily: "IBM Plex Arabic",),
          fillColor: widget.color ?? Colors.transparent,
          filled: widget.color != null ? true : false,
          errorText: widget.errorText ,
          prefixIcon:widget.preIcon ??  Padding(
                  padding:const  EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 1,
                    child:const Icon(
                      Icons.lock,
                      size: 15,
                      color: Colors.white,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                )
            ,
          suffixIcon: IconButton(
            icon: see == true
                ?const Icon(
                   Icons.visibility_off,
              color: MyTheme.blue,
                  )
                :const Icon(
                   Icons.visibility,
//                color: MyColors.blue,
                  ),
            onPressed: () {
              setState(() {
                see = !see;
              });
            },
          ),
          contentPadding: EdgeInsets.symmetric(vertical: widget.contentPaddingVertically ?? 14, horizontal: 10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
            borderSide:const BorderSide(
              color: MyTheme.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
            borderSide:const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
            borderSide:const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
