import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/authentication.dart';
import 'package:nmax/main.dart';
import 'package:nmax/screens/auth/second_screen.dart';
import 'package:nmax/utils/outputs.dart';
import 'package:nmax/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _controller = PageController();
  int pgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => pgIndex = value),
            children: [
              Center(
                child: Container(
                  height: AppSizing.getHeight(context) * 0.6,
                  width: AppSizing.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1733346936067-e0a17f32c14b?q=80&w=1852&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WHEN YOU HAVE A TASTE',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.permanentMarker(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                              )
                            ],
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'DIFFERENT!',
                          style: GoogleFonts.permanentMarker(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                              )
                            ],
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Center(
                child: Container(
                  height: AppSizing.getHeight(context) * 0.6,
                  width: AppSizing.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1733309544294-700e617cba60?q=80&w=1930&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'To Match Your Vibe',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sarina(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                              )
                            ],
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Positive!',
                          style: GoogleFonts.pacifico(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                              )
                            ],
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Center(
                child: Container(
                  height: AppSizing.getHeight(context) * 0.6,
                  width: AppSizing.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1708755574512-fd4e8ab860f8?q=80&w=1864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FIND YOUR SELF',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nothingYouCouldDo(
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 30,
                              )
                            ],
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Find YOU!',
                          style: GoogleFonts.shadowsIntoLight(
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 20,
                              )
                            ],
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: SmoothPageIndicator(
              controller: _controller, // PageController
              count: 3,
              effect: WormEffect(
                dotHeight: 8,
                dotColor: Colors.white10,
                activeDotColor: [
                  Colors.redAccent,
                  Colors.yellowAccent,
                  Colors.lightBlueAccent,
                ].elementAt(pgIndex),
              ), // your preferred effect
              onDotClicked: (index) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Visibility(
              visible: pgIndex != 2,
              replacement: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.lightBlueAccent,
                enableFeedback: true,
                onTap: () async {
                  UserCredential? cred;
                  try {
                    cred = await signInWithGoogle();
                    await checkHasAccount(cred.user!.email ?? '')
                        ? Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => NavScreen(),
                            ))
                        : Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SecondScreen(
                                cred: cred,
                              ),
                            ));
                  } catch (e) {
                    showSnack(context, 'Failed: ${e.toString()}');
                    debugPrint(e.toString());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: Colors.lightBlueAccent,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 16,
                          color: Colors.white,
                        ),
                        Text(
                          'Sign in with Google',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(
                      delay: Duration(milliseconds: 700),
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 1000),
                    ),
              ),
              child: IconButton(
                  onPressed: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  icon: Icon(CupertinoIcons.arrow_right_to_line_alt)),
            ),
          ),
        ],
      ),
    );
  }
}
