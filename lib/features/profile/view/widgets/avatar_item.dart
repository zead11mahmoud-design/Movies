import 'package:flutter/material.dart';

class AvatarItem extends StatelessWidget {
  final String image;
  final bool isSelected;

  const AvatarItem({super.key, required this.image, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: CircleAvatar(backgroundImage: AssetImage(image)),
    );
  }
}
