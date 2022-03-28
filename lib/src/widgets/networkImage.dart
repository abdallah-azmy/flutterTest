import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? image;
  final BoxFit? fit;

  const CustomNetworkImage({Key? key, @required this.image, this.fit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        color: Colors.black,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(Icons.error),
        ),
      );
    }
    try {
      return PhysicalModel(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage.assetNetwork(
          image: image!,
          fit: fit ?? BoxFit.cover,

          imageErrorBuilder: (context, exception, stackTrace) {
            print("$exception");
            return const Icon(Icons.error);
          },
          fadeInDuration: const Duration(milliseconds: 500),
          placeholder: "assets/appleLoading.gif",placeholderScale: .2,

          // loadingBuilder: (BuildContext context, Widget child,
          //     ImageChunkEvent loadingProgress) {
          //   if (loadingProgress == null) return child;
          //   return Center(
          //     child: CircularProgressIndicator(
          //       color: MyColors.blueBlack2,
          //       value: loadingProgress.expectedTotalBytes != null
          //           ? loadingProgress.cumulativeBytesLoaded /
          //               loadingProgress.expectedTotalBytes
          //           : null,
          //     ),
          //   );
          // },
        ),
      );
    } catch (e) {
      print(e);
      return Container(
        color: Colors.black,
        child:const Center(
          child: Icon(Icons.error),
        ),
      );
    }
  }
}
