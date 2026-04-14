import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/theme/app_theme.dart';

class DefaulteBotton extends StatelessWidget {
  String text;
  Color textColor;
  Color colorBotton;
  double border;
  VoidCallback onPressed;
  String? prefixIconImageName;
  String? suffixIconImageName;

  DefaulteBotton({
    required this.text,
    required this.onPressed,
    this.textColor = AppTheme.black,
    this.colorBotton = AppTheme.primary,
    this.border = 0,
    this.prefixIconImageName,
    this.suffixIconImageName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBotton,
          foregroundColor: textColor,
          side: border == 0
              ? null
              : BorderSide(color: AppTheme.primary, width: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            prefixIconImageName == null
                ? SizedBox()
                : SvgPicture.asset(
                    'assets/icons/$prefixIconImageName.svg',
                    width: 10,
                    height: 20,
                  ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                text,
                style: TextTheme.of(
                  context,
                ).titleMedium!.copyWith(color: textColor, fontWeight: .w400),
              ),
            ),
            SizedBox(width: 10),
            suffixIconImageName == null
                ? SizedBox()
                : SvgPicture.asset(
                    'assets/icons/$suffixIconImageName.svg',
                    width: 10,
                    height: 20,
                  ),
          ],
        ),
      ),
    );
  }
}
