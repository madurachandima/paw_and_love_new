import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';

class CustomeCircularProgress extends StatelessWidget {
  Color? color;
  CustomeCircularProgress({Key? key, this.color = ColorConfig.orange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
