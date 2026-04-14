import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_theme.dart';

class LanguageSwitcher extends StatefulWidget {
  final bool isEnglish;
  final Function(bool) onChanged;

  const LanguageSwitcher({
    super.key,
    required this.isEnglish,
    required this.onChanged,
  });

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.7,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary, width: 2),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: widget.isEnglish
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.isEnglish) return;
                  widget.onChanged(true);
                  setState(() {});
                },
                child: SvgPicture.asset('assets/icons/usa.svg'),
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.isEnglish) return;
                  widget.onChanged(false);
                  setState(() {});
                },
                child: SvgPicture.asset('assets/icons/egypt.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
