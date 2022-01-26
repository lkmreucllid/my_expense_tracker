import 'package:flutter/material.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/content_card.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/top_bar.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/rounded_button.dart';

class FlightStepper extends StatelessWidget {
  const FlightStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar(height: 210.0),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  _buildButtonsRow(),
                  Expanded(
                    child: ContentCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          RoundedButton(title: 'ONE WAY', callback: () {}),
          RoundedButton(title: 'ROUND TRIP', callback: () {}),
          RoundedButton(
              title: 'MULTIPLE CITIES', selected: true, callback: () {}),
        ],
      ),
    );
  }
}
