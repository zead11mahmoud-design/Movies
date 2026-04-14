import 'package:flutter/material.dart';

class ScreenshotItem extends StatelessWidget {
  String url;
  ScreenshotItem({required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          url,
          height: 200,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
