import 'package:flutter/material.dart';
import 'package:fluttertest/src/helper/myTheme.dart';

class SpecialTextFieldSearch extends StatelessWidget {
  final String? hint;
  final Function? onChange;

  const SpecialTextFieldSearch({Key? key, this.hint, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: MyTheme.styleBlack1,
      onChanged: (v) => onChange!(v),
      decoration: InputDecoration(
        hintStyle: MyTheme.styleHint,
        filled: true,
        fillColor: MyTheme.grey0,
        hintText: "امر تدلل وش تحتاج",
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(Icons.search,color: MyTheme.grey,),
        ),
      ),

    );
  }
}
