import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/screens/channels/channels_screen.dart';
import 'package:nmax/screens/direct/direct_screen.dart';
import 'package:nmax/screens/home/home_screen.dart';
import 'package:nmax/screens/profile_screen.dart';
import 'package:nmax/utils/styles.dart';

class NavScreen extends StatefulWidget {
  static String user = '';

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final _pageController = PageController();
  int i = 0;

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
    setState(() {
      i = _pageController.page!.toInt();
    });
  }

  List<Widget> _pages = [
    HomeScreen(),
    ChannelsScreen(),
    DirectScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setUser();
  }

  setUser() async {
    NavScreen.user = await getUsernameFromEmail();
  }

  @override
  Widget build(BuildContext context) {
    if (AppSizing.getWidth(context) > 600)
      return Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: GNav(
                    backgroundColor: Colors.transparent,
                    activeColor: Colors.white,
                    color: Colors.white70,
                    gap: 5,
                    padding: EdgeInsets.all(10),
                    onTabChange: _onItemTapped,
                    tabs: [
                      GButton(
                        backgroundColor: Colors.deepPurple.shade800,
                        icon: CupertinoIcons.flame,
                        text: 'Feed',
                      ),
                      GButton(
                        backgroundColor: Colors.deepOrange,
                        icon: CupertinoIcons.cloud,
                        text: 'Channels',
                      ),
                      GButton(
                        backgroundColor: Colors.pinkAccent,
                        icon: CupertinoIcons.paperplane,
                        text: 'Direct',
                      ),
                      GButton(
                        backgroundColor: Colors.blueAccent,
                        icon: CupertinoIcons.person,
                        text: 'Profile',
                      )
                    ],
                  ),
                ),
                space(15),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: _pages,
                    controller: _pageController,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
        controller: _pageController,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          backgroundColor: Colors.transparent,
          activeColor: Colors.white,
          color: Colors.white70,
          gap: 5,
          padding: EdgeInsets.all(10),
          onTabChange: _onItemTapped,
          tabs: [
            GButton(
              backgroundColor: Colors.deepPurple.shade800,
              icon: CupertinoIcons.flame,
              text: 'Feed',
            ),
            GButton(
              backgroundColor: Colors.deepOrange,
              icon: CupertinoIcons.cloud,
              text: 'Channels',
            ),
            GButton(
              backgroundColor: Colors.pinkAccent,
              icon: CupertinoIcons.paperplane,
              text: 'Direct',
            ),
            GButton(
              backgroundColor: Colors.blueAccent,
              icon: CupertinoIcons.person,
              text: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
