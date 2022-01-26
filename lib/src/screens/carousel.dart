import 'dart:ui';

import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final imagesAssets = [
    "apex",
    "cod",
    "destiny",
    "fc3",
    "game_4",
    "ghost",
    "mk11",
    "nfs",
    "pubg",
    "mk112"
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: Container(
            key: ValueKey<int>(currentIndex),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/${imagesAssets[currentIndex]}.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.55,
          child: PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                });
              },
              itemCount: imagesAssets.length,
              itemBuilder: (context, int index) {
                return FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/${imagesAssets[index]}.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
