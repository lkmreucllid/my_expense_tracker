import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offSet = 0.0;
  double _page = 0.0;
  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offSet = pageController.offset;
      _page = pageController.page as double;
      notifyListeners();
    });
  }

  double get offset => _offSet;
  double get page => _page;
}

class MainTravelPage extends StatefulWidget {
  @override
  _MainTravelPageState createState() => _MainTravelPageState();
}

class _MainTravelPageState extends State<MainTravelPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.centerLeft,
          children: [
            LeopardImage(),
            PageView(
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              children: [
                LeopardPage(),
                VulturePage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Positioned(
          left: -0.85 * notifier.offset,
          width: MediaQuery.of(context).size.width * 1.6,
          child: child as Widget,
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/images/leopard.png'),
      ),
    );
  }
}

class LeopardPage extends StatelessWidget {
  const LeopardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    return Image.asset('assets/images/leopard.png');
  }
}

class VulturePage extends StatelessWidget {
  const VulturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/vulture.png');
  }
}
