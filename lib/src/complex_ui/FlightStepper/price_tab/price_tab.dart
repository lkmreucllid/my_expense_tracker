import 'package:flutter/material.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/fade_route.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/animarted_plane_Icon.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/animated_card.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/animated_dot.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/fight_stop_model.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/price_tab/flight_stop_card.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/ticket_tab/ticket_page.dart';

class PriceTab extends StatefulWidget {
  final double height;
  final VoidCallback onPlaneFlightStart;
  const PriceTab(
      {Key? key, required this.height, required this.onPlaneFlightStart})
      : super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  final double _initialPlanePaddingBottom = 16.0;
  final double _minPlanePaddinTop = 16.0;
  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];

  final List<GlobalKey<FlightStopCardState>> _stopKeys = [];

  late AnimationController _planeSizeAnimationController;
  late AnimationController _planeTravelAnimationController;
  late AnimationController _dotsAnimationController;
  late AnimationController _fabAnimationController;
  late Animation<double> _planeSizeAnimation;
  late Animation _planeTravelAnimation;
  late Animation _fabAnimation;

  List<Animation<double>> _dotsPosition = [];
  List<double> listFinalTopMargin = [];

  double get _planeTopPadding =>
      _minPlanePaddinTop +
      (1 - _planeTravelAnimation.value) * _maxPlanePaddingTop;

  double get _maxPlanePaddingTop =>
      widget.height -
      _minPlanePaddinTop -
      _initialPlanePaddingBottom -
      _planeSize;

  double get _planeSize => _planeSizeAnimation.value;

  @override
  void initState() {
    super.initState();

    _initSizeAnimations();
    _initPlaneTravelAnimations();
    _initDotAnimationController();
    _initDotAnimations();
    _initFabAnimationController();
    _flightStops.forEach(
        (stops) => _stopKeys.add(new GlobalKey<FlightStopCardState>()));
    _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    _planeTravelAnimationController.dispose();
    _dotsAnimationController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[_buildPlane()]
          ..addAll(_flightStops.map(_buildStopCard))
          ..addAll(_flightStops.map(_mapFlightStopToDot))
          ..add(_buildFab()),
      ),
    );
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = listFinalTopMargin[index] -
        (0.5 * FlightStopCard.height) +
        (AnimatedDot.size * 0.5);
    bool isLeft = index.isOdd;

    return Padding(
      padding: EdgeInsets.only(top: topMargin),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isLeft ? Container() : Expanded(child: Container()),
          Expanded(
            child: FlightStopCard(
              key: _stopKeys[index],
              flightStop: stop,
              isLeft: isLeft,
            ),
          ),
          !isLeft ? Container() : Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _mapFlightStopToDot(stop) {
    int index = _flightStops.indexOf(stop);
    bool isStartOrEnd = index == 0 || index == _flightStops.length - 1;
    Color color = isStartOrEnd ? Colors.red : Colors.green;
    return AnimatedDot(
      animation: _dotsPosition[index],
      color: color,
    );
  }

  Widget _mapFlightStopCard(stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = _dotsPosition[index].value -
        0.5 * (FlightStopCard.height - AnimatedDot.size);
    bool isLeft = index.isOdd;
    return AnimatedCard(
      animation: _dotsPosition[index],
      isLeft: isLeft,
    );
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 16.0,
      child: ScaleTransition(
        scale: _fabAnimation as Animation<double>,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(FadeRoute(builder: (context) => TicketsPage())),
          child: Icon(Icons.check, size: 36.0),
        ),
      ),
    );
  }

  Widget _buildPlane() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      child: Column(
        children: <Widget>[
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
          Container(
            width: 2.0,
            height: _flightStops.length * FlightStopCard.height * 0.8,
            color: Color.fromARGB(255, 200, 200, 200),
          ),
        ],
      ),
      builder: (context, child) => Positioned(
        top: _planeTopPadding,
        child: child as Widget,
      ),
    );
  }

  _initSizeAnimations() {
    _planeSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 500), () {
            widget.onPlaneFlightStart();
            _planeTravelAnimationController.forward();
          });
          Future.delayed(Duration(milliseconds: 700), () {
            _dotsAnimationController.forward();
          });
        }
      });
    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0).animate(
        CurvedAnimation(
            parent: _planeSizeAnimationController, curve: Curves.easeOut));
  }

  _initPlaneTravelAnimations() {
    _planeTravelAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _planeTravelAnimation = CurvedAnimation(
        parent: _planeTravelAnimationController, curve: Curves.fastOutSlowIn);
  }

  void _initDotAnimationController() {
    _dotsAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animateFlightStopCards().then((value) => _animateFab());
        }
      });
  }

  void _initDotAnimations() {
    final double slideDurationInterval = 0.4;
    final double slideDelayInterval = 0.2;
    double startingMarginTop = widget.height;
    double minMarginTop =
        _minPlanePaddinTop + _planeSize + 0.5 * (0.8 * FlightStopCard.height);

    for (int i = 0; i < _flightStops.length; i++) {
      final start = slideDelayInterval * i;
      final end = start + slideDurationInterval;
      double finalMarginTop = minMarginTop + i * (0.8 * FlightStopCard.height);

      Animation<double> animation = new Tween(
        begin: startingMarginTop,
        end: finalMarginTop,
      ).animate(
        new CurvedAnimation(
          parent: _dotsAnimationController,
          curve: new Interval(start, end, curve: Curves.easeOut),
        ),
      );
      _dotsPosition.add(animation);
      listFinalTopMargin.add(finalMarginTop);
    }
  }

  Future _animateFlightStopCards() async {
    return Future.forEach(_stopKeys, (GlobalKey<FlightStopCardState> stopKey) {
      return new Future.delayed(Duration(milliseconds: 250), () {
        if (stopKey.currentState != null && stopKey.currentContext != null) {
          stopKey.currentState!.runAnimation();
        }
      });
    });
  }

  void _initFabAnimationController() {
    _fabAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _fabAnimation = new CurvedAnimation(
        parent: _fabAnimationController, curve: Curves.easeOut);
  }

  _animateFab() {
    _fabAnimationController.forward();
  }
}
