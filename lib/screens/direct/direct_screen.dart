import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/chating.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/navscreen.dart';
import 'package:nmax/models/user.dart';
import 'package:nmax/screens/direct/gemini.dart';
import 'package:nmax/utils/styles.dart';

class DirectScreen extends StatelessWidget {
  const DirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct',
        ),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1534271057238-c2c170a76672?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => AppSizing.getWidth(context) > 600
                          ? showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                clipBehavior: Clip.antiAlias,
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: 600,
                                        maxHeight:
                                            AppSizing.getHeight(context) * 0.8),
                                    child: Gemini()),
                              ),
                            )
                          : showModalBottomSheet(
                              context: context,
                              builder: (context) => Gemini(),
                            ),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Container(
                          // height: 65,
                          width: double.maxFinite,
                          child: Center(
                            child: Wrap(
                              spacing: 5,
                              children: [
                                Text(
                                  'Ask Gemini',
                                  style: GoogleFonts.nothingYouCouldDo(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.pinkAccent,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                space(25),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(NavScreen.user)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError ||
                          snapshot.hasData == false)
                        return Center(
                          child: SizedBox(
                            width: AppSizing.getWidth(context) * 0.4,
                            height: 1,
                            child: LinearProgressIndicator(
                              color: Colors.redAccent,
                            ),
                          ),
                        );

                      final List data = snapshot.data!.data()?['direct'] ?? [];

                      List<String> list = data
                          .map(
                            (e) => e.toString(),
                          )
                          .toList();

                      if (list.isEmpty)
                        return AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Center(
                              child: SizedBox(
                            width: AppSizing.getWidth(context) * 0.6,
                            child: SvgPicture.asset(
                              'assets/ph2.svg',
                            ),
                          )),
                        );

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        reverse: true,
                        itemBuilder: (context, index) => FutureBuilder(
                            future: Future.wait([
                              getUser(list[index]),
                              isNewMessage(list[index]),
                            ]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  snapshot.hasError ||
                                  snapshot.hasData == false) return Card();

                              final user = snapshot.data?.first as UserModel;
                              bool isNew = snapshot.data?.last as bool;

                              return Card(
                                clipBehavior: Clip.antiAlias,
                                color: isNew
                                    ? Colors.pinkAccent.withOpacity(0.5)
                                    : Colors.pinkAccent.withOpacity(0.2),
                                child: ListTile(
                                  onTap: () => context.push('/m/${user.username}'),
                                  leading: ClipOval(
                                    child: Image.asset(
                                      'assets/icon.png',
                                      color: Colors.pinkAccent.shade700,
                                      colorBlendMode: BlendMode.color,
                                      width: 35,
                                    ),
                                  ),
                                  title: Text(
                                    user.username,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.fg,
                                      fontSize: 14,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Recently texted',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.fg.withAlpha(100),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
