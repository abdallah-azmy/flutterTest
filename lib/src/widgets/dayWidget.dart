import 'package:flutter/material.dart';
import 'package:fluttertest/src/helper/myTheme.dart';
import 'package:fluttertest/src/provider/dataProvider.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({Key? key,required this.provider ,required this.index}) : super(key: key);

  final int? index;
  final DataProvider? provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        provider!.selectDay(index: index);
      },
      child: Container(
        height: 28,
        width: MediaQuery.of(context)
            .size
            .width *
            .18,
        decoration: BoxDecoration(
            gradient:provider!.days![index!]
            ["selected"] ==
                true
                ?const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffdd0539),
                Color(0xffdc0539),
                Color(0xffed3b66),
              ],
            ):const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.grey
              ],
            ),
            color: provider!.days![index!]
            ["selected"] ==
                true
                ? MyTheme.lightRed
                : MyTheme.grey.withOpacity(.1),
            borderRadius:
            BorderRadius.circular(6)),
        margin: const EdgeInsets.symmetric(
            horizontal: 10),
        child: Center(
          child: Text(
              provider!.days![index!]["day"],
              style: provider!.days![index!]
              ["selected"] ==
                  true
                  ? MyTheme.styleWhite0
                  : MyTheme.styleBlack0),
        ),
      ),
    );
  }
}
