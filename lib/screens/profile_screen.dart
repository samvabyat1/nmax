import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/home.dart';
import 'package:nmax/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel? user;
  final authuser = FirebaseAuth.instance.currentUser;

  Color cardcolor = Colors.grey;

  void getCardColor() async {
    cardcolor = await getImagePalette(user!.picture == null
        ? authuser!.photoURL.toString()
        : user!.picture.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getCardColor();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(authuser!.email.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              snapshot.hasData == false) return Scaffold();

          user = snapshot.data;

          // getCardColor();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: FlipCard(
                      fill: Fill
                          .fillBack, // Fill the back side of the card to make in the same size as the front.
                      direction: FlipDirection.HORIZONTAL, // default
                      side: CardSide.FRONT, // The side to initially display.
                      front: Card(
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundImage: user == null
                                      ? null
                                      : CachedNetworkImageProvider(
                                          user!.picture == null
                                              ? authuser!.photoURL.toString()
                                              : user!.picture.toString()),
                                  child: Baseline(
                                    baseline: 200,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Transform.rotate(
                                      angle: -0.1,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 6,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                '@',
                                                style: GoogleFonts.oswald(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              Text(
                                                user!.username.toUpperCase(),
                                                style: GoogleFonts.oswald(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(10),
                                  // splashColor: Colors.blueAccent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 3),
                                      child: Text(
                                        'Edit profile',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Tap to flip',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      back: Card(
                        color: Colors.blueAccent,
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              'assets/icon_bg.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
