import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nmax/backend/tests.dart';
import 'package:nmax/firebase_options.dart';
import 'package:nmax/navscreen.dart';
import 'package:nmax/screens/auth/first_screen.dart';
import 'package:nmax/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // testAddRandomUsers();
  // testAddApiPosts();
  getAllPosts();
  // testAddMannualAsks();
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
          foregroundColor: AppColors.fg,
          // centerTitle: true,
        ),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
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
