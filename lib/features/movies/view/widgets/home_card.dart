import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack( alignment: Alignment.center,
      children: [
        Image.asset('assets/images/1917_movie.png'),
        Container(
          decoration: BoxDecoration(color: Color(0xff121312)),
          child: Row(
            children: [
              Text('7.7', style: TextStyle(fontSize: 16)),
              Icon(Icons.star, color: Color(0xffF6BD00)),
            ],
          ),
        ),
      ],
    );
  }
}
