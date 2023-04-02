import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String title;
  const DemoPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(color: AppColor.bluegreen, fontSize: 30),
      ),
    );
  }
}
