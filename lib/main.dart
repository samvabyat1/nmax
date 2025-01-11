import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nmax/backend/tests.dart';
import 'package:nmax/firebase_options.dart';
import 'package:nmax/routes.dart';
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
    return MaterialApp.router(
      routerConfig: MRoutes().router,
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
      // home: SplashScreen(),
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
          (user) => user == null ? context.go('/auth') : context.go('/h'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
