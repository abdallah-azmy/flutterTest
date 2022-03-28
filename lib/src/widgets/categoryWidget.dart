import 'package:flutter/material.dart';
import 'package:fluttertest/src/helper/myTheme.dart';
import 'package:fluttertest/src/provider/dataProvider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key,required this.provider , this.index}) : super(key: key);

  final int? index;
  final DataProvider? provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        provider!.selectCategory(index: index);
      },
      child: Container(
        height: 32,
        width: MediaQuery.of(context)
            .size
            .width *
            .22,
        decoration: BoxDecoration(
            color: provider!.categories![index!]
            ["selected"] ==
                true
                ? MyTheme.lightRed
                : Colors.white,
            borderRadius:
            BorderRadius.circular(6)),
        margin: const EdgeInsets.symmetric(
            horizontal: 10),
        child: Center(
          child: Text(
              provider!.categories![index!]
              ["categoryName"]!,
              style: provider!.categories![index!]
              ["selected"] ==
                  true
                  ? MyTheme.styleWhite1
                  : MyTheme.styleBlack1),
        ),
      ),
    );
  }
}
