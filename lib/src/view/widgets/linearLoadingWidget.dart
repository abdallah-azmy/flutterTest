import 'package:flutter/material.dart';

class LinearLoadingWidget extends StatelessWidget {
  const LinearLoadingWidget({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 45.0,
        child: const Center(child: LinearProgressIndicator()));
  }
}
