import 'package:flutter/material.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/multicity_input.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/price_tab.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({Key? key}) : super(key: key);

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool showInput = true;
  bool showInputTabOptions = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!showInput) {
          setState(() {
            showInput = true;
            showInputTabOptions = true;
          });
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: new Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 3,
          child: new LayoutBuilder(builder:
              (BuildContext buildContext, BoxConstraints viewportContraints) {
            return Column(
              children: <Widget>[
                _buildTabBar(),
                _buildContentContainer(viewportContraints),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: new Color(0xFFEEEEEE),
          ),
        ),
        new TabBar(
          tabs: [
            Tab(
              text: showInputTabOptions ? 'Flight' : 'Price',
            ),
            Tab(
              text: showInputTabOptions ? 'Train' : 'Duration',
            ),
            Tab(
              text: showInputTabOptions ? 'Bus' : 'Stops',
            ),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildContentContainer(BoxConstraints viewPortConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewPortConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(
            child: showInput
                ? _buildMulticityTab()
                : PriceTab(
                    height: viewPortConstraints.maxHeight - 48.0,
                    onPlaneFlightStart: () {
                      setState(() {
                        showInputTabOptions = false;
                      });
                    }),
          ),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        MulticityInput(),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () => setState(() => showInput = false),
            child: Icon(
              Icons.timeline,
              size: 36.0,
            ),
          ),
        ),
      ],
    );
  }
}
