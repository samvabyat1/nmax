import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/models/user.dart';
import 'package:nmax/navscreen.dart';
import 'package:nmax/utils/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget profileDesk(UserModel? user, bool isOwnProfile, BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Profile',
      ),
    ),
    body: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: FlipCard(
                          fill: Fill
                              .fillBack, // Fill the back side of the card to make in the same size as the front.
                          direction: FlipDirection.HORIZONTAL, // default
                          side:
                              CardSide.FRONT, // The side to initially display.
                          front: Card(
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 100,
                                      backgroundImage: user!.picture == null
                                          ? AssetImage(
                                              'assets/icon.png',
                                            )
                                          : CachedNetworkImageProvider(
                                              user.picture.toString()),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '@',
                                                    style: GoogleFonts.oswald(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    user.username.toUpperCase(),
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
                                          border: Border.all(
                                              color: isOwnProfile
                                                  ? Colors.grey
                                                  : Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 3),
                                          child: Text(
                                            isOwnProfile
                                                ? 'Edit profile'
                                                : 'Add homie',
                                            style: GoogleFonts.poppins(
                                              color: isOwnProfile
                                                  ? Colors.grey[600]
                                                  : Colors.black,
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.asset(
                                      'assets/icon_bg.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Transform.rotate(
                                      angle: 0.1,
                                      child: QrImageView(
                                        data:
                                            'https://nmaxapp.web.app/i/${user.username}',
                                        size: 200,
                                        embeddedImage:
                                            AssetImage('assets/icon.png'),
                                        dataModuleStyle: QrDataModuleStyle(
                                          color: Colors.white,
                                        ),
                                        eyeStyle: QrEyeStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: -0.1,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '@',
                                            style: GoogleFonts.oswald(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            user.username.toUpperCase(),
                                            style: GoogleFonts.oswald(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      space(25),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.grey[900],
                        child: ListTile(
                          onTap: () => context.push('/m/${user.username}'),
                          trailing: Icon(
                            CupertinoIcons.paperplane,
                            // color: AppColors.fg,
                          ),
                          title: Text(
                            'Message ${user.username == NavScreen.user ? 'Yourself' : user.username}',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              // color: AppColors.fg,
                              fontSize: 14,
                            ),
                          ),
                          textColor: Colors.grey[600],
                          iconColor: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getUserPosts(user.username),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        snapshot.hasData == false) return Container();

                    if (snapshot.data!.isEmpty) return Container();

                    var posts = snapshot.data ?? [];

                    return DraggableScrollableSheet(
                      initialChildSize: 1.0,
                      minChildSize: 0.1,
                      builder: (context, scrollController) => ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          color: Colors.grey[900],
                          child: GridView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 50,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              var post = posts[index];
                              return ClipRRect(
                                // clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(20),
                                child: GridTile(
                                    child: Image.network(
                                  post.url.toString(),
                                  fit: BoxFit.cover,
                                )),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ),
  );
}
