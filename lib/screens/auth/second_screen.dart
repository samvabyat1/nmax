import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nmax/backend/authentication.dart';
import 'package:nmax/main.dart';
import 'package:nmax/utils/outputs.dart';
import 'package:nmax/utils/styles.dart';

class SecondScreen extends StatefulWidget {
  final UserCredential? cred;
  const SecondScreen({super.key, required this.cred});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  var _controller = TextEditingController();
  bool usernameAvailable = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: AppSizing.getHeight(context) * 0.6,
            width: AppSizing.getWidth(context) * 0.9,
            decoration: BoxDecoration(
                // color: AppColors.fg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  )
                ]),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type \nUsername',
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: _controller,
                    style: TextStyle(color: AppColors.fg),
                    decoration: InputDecoration(
                        suffixIcon: _controller.text.isEmpty
                            ? null
                            : usernameAvailable
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  )),
                    onChanged: (value) async {
                      usernameAvailable = !await checkUsernameAvailable(value);
                      setState(() {});
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-z0-9_.]')),
                    ],
                    onSubmitted: (value) async {
                      if (value.isNotEmpty && usernameAvailable) {
                        try {
                          await createAccount(widget.cred!, value);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NavScreen(),
                              ));
                        } catch (e) {
                          showSnack(context, 'Something went wrong!');
                        }
                      }
                    },
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
