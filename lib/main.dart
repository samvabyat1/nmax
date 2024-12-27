import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nmax/backend/tests.dart';
import 'package:nmax/firebase_options.dart';
import 'package:nmax/screens/auth/first_screen.dart';
import 'package:nmax/screens/direct/direct_screen.dart';
import 'package:nmax/screens/home/home_screen.dart';
import 'package:nmax/screens/profile_screen.dart';
import 'package:nmax/screens/servers_screen.dart';
import 'package:nmax/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // testAddRandomUsers();
  // testAddApiPosts();
  getAllPosts();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bg,
          titleTextStyle: AppTypography.ha,
        ),
        scaffoldBackgroundColor: AppColors.bg,
        iconTheme: IconThemeData(color: AppColors.fg),
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(
          (user) => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    user == null ? FirstScreen() : NavScreen(),
              )),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class NavScreen extends StatefulWidget {
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
    ServersScreen(),
    DirectScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
              text: 'Servers',
            ),
            GButton(
              backgroundColor: Colors.pinkAccent,
              icon: CupertinoIcons.paperplane,
              text: 'Direct',
            ),
            GButton(
              backgroundColor: Colors.blueAccent,
              icon: LineIcons.user,
              text: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
