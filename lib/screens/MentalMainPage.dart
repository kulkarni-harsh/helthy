import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/screens/ScreenList.dart';

class MentalMainPage extends StatefulWidget {
  const MentalMainPage({Key? key}) : super(key: key);

  @override
  _MentalMainPageState createState() => _MentalMainPageState();
}

class _MentalMainPageState extends State<MentalMainPage> {
  int _page = 0;
  // ignore: unused_field
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(Icons.home_filled, size: 30),
            Icon(Icons.auto_graph_sharp, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: kPrimaryColor.withOpacity(0.6),
          animationCurve: Curves.easeInOut,
          height: 50,
          animationDuration: Duration(milliseconds: 600),
        ),
        body: kPageList[_page]);
  }
}
