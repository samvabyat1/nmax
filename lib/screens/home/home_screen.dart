import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nmax/screens/home/feed_screen.dart';
import 'package:nmax/screens/home/fav_screen.dart';
import 'package:nmax/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int togbtn = 0;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) => setState(() => togbtn = value),
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          FeedScreen(),
          FavScreen(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 125,
        child: AnimatedToggleSwitch<int>.size(
          textDirection: TextDirection.ltr,
          current: togbtn,
          values: const [0, 1],
          iconOpacity: 0.5,
          indicatorSize: const Size.fromWidth(100),
          iconBuilder: (value) => [
            Icon(CupertinoIcons.bolt_fill),
            Icon(CupertinoIcons.heart_fill),
          ].elementAt(value),
          borderWidth: 6,
          iconAnimationType: AnimationType.onHover,
          style: ToggleStyle(
            backgroundColor: AppColors.bg1,
            borderColor: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          styleBuilder: (i) => ToggleStyle(
              indicatorColor:
                  [Colors.deepPurple[800], Colors.pink].elementAt(i)),
          onChanged: (i) {
            setState(() => togbtn = i);
            _controller.animateToPage(i,
                curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
          },
        ),
      ),
    );
  }
}
