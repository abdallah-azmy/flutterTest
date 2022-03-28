import 'package:flutter/material.dart';
import 'package:fluttertest/src/helper/myTheme.dart';
import 'package:fluttertest/src/provider/dataProvider.dart';
import 'package:fluttertest/src/widgets/networkImage.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.provider, this.index})
      : super(key: key);

  final int? index;
  final DataProvider? provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: MyTheme.grey.withOpacity(.05),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
         width: 80,
          height: 110
          ,child: CustomNetworkImage(image: provider!.products![index!]["image"]!,)),
         const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider!.products![index!]["name"]!,
                    style: MyTheme.styleBlackBold),
                Row(
                  children: [
                    const Icon(Icons.threesixty_sharp),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        provider!.products![index!]["calories"]! +
                            " سعرات حرارية ",
                        style: MyTheme.styleHint),
                  ],
                ),
                Row(

                  children: [
                    Column(
                      children: [
                        Text(
                            provider!.products![index!]["carb"]! +
                                "(ح)",
                            style: MyTheme.styleBlue),
                        const SizedBox(height: 2,),

                        const Text("كارب", style: MyTheme.styleHint),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                              provider!.products![index!]["protein"]! +
                                  "(ح)",
                              style: MyTheme.styleOrange),
                         const SizedBox(height: 2,),

                          const Text("بروتين", style: MyTheme.styleHint),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            provider!.products![index!]["fats"]! +
                                "(ح)",
                            style: MyTheme.styleRed),
                        const SizedBox(height: 2,),

                        const Text("دهون", style: MyTheme.styleHint),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
         const SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                      color: MyTheme.black,
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Center(
                      child: Text(provider!.products![index!]["price"]! + "ج",
                          style: MyTheme.styleGreySmall),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xffdd0539),
                        Color(0xffee3f69),
                      ]),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 17,
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5,),
        ],
      ),
    );
  }
}
