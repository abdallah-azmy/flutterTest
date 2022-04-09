import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';

class SpecialTextField extends StatelessWidget {
  const SpecialTextField(
      {Key? key,
      this.icon,
      this.validator,
      this.contentPaddingVertically,
      this.radius,
      this.color,
      this.controller,
      this.label,
      this.enable,
      this.maxLines,
      this.minLines,
      this.type,
      this.hint,
      this.suffixIcon,
      this.errorText,
      this.onChange,
      this.init,
      this.edit,
      this.onChangeCountry,
      this.onInit})
      : super(key: key);

  final String? label;
  final Widget? icon;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType? type;
  final String? hint;
  final String? errorText;
  final Function? onChange;
  final String? init;
  final bool? edit;
  final Color? color;
  final TextEditingController? controller;
  final double? contentPaddingVertically;
  final double? radius;
  final bool? enable;
  final int? minLines;
  final int? maxLines;
  final Function? onChangeCountry;
  final Function? onInit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        initialValue: init,
        controller: controller,
        enabled: enable ?? true,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        keyboardType: type ?? TextInputType.phone,
        onFieldSubmitted: (v) {},
        onChanged: (v) {
          onChange!(v);
        },
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return "${hint ?? label} مطلوب";
              }
              return null;
            },
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Padding(padding: const EdgeInsets.all(5.0), child: icon)
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(padding: const EdgeInsets.all(8.0), child: suffixIcon)
              : null,
          labelText: label,
          errorText: errorText,
          fillColor: color ?? Colors.transparent,
          filled: color != null ? true : false,
          hintText: hint ?? '',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: "IBM Plex Arabic",
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: contentPaddingVertically ?? 14, horizontal: 10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15.0),
            borderSide: const BorderSide(
              color: MyTheme.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
