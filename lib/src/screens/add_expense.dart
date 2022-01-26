import 'package:flutter/material.dart';
import 'package:swipe_deck/swipe_deck.dart';

class AddExpense extends StatelessWidget {
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
  final borderRadius = BorderRadius.circular(20.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwipeDeck(
        startIndex: 3,
        aspectRatio: 4 / 3,
        emptyIndicator: Container(
          child: Center(
            child: Text("Nothing Here"),
          ),
        ),
        widgets: imagesAssets
            .map((e) => GestureDetector(
                  onTap: () {
                    print(e);
                  },
                  child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.asset(
                        "assets/images/$e.jpg",
                        fit: BoxFit.cover,
                      )),
                ))
            .toList(),
      ),
    );
  }
}
