import 'package:flutter/material.dart';

class AvatarPicker extends StatefulWidget {
  final Function(String avatar)? onChanged;

  const AvatarPicker({super.key, this.onChanged});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  PageController controller = PageController(
    viewportFraction: 0.35,
    initialPage: 1,
  );
  int currentIndex = 1;
  List<String> avatars = [
    'assets/images/avatar_3.png',
    'assets/images/avatar_1.png',
    'assets/images/avatar_2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: avatars.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
          widget.onChanged?.call(avatars[index]);
        },
        itemBuilder: (context, index) {
          bool isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () {
              controller.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Center(
              child: AnimatedScale(
                duration: Duration(milliseconds: 300),
                scale: isSelected ? 1 : 0.6,
                child: Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(avatars[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
