import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/screens/post_upload_screen.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      'Your Favs',
                      style: GoogleFonts.montserrat(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/wish-list.png',
                        width: 32,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  // height: AppSizing.getHeight(context) * 0.45,
                  width: double.maxFinite,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: CardSwiper(
                      padding: EdgeInsets.all(5),
                      cardsCount: 20,
                      cardBuilder: (context, index, horizontalOffsetPercentage,
                          verticalOffsetPercentage) {
                        return Card(
                          color: Colors.pink[300],
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => PostUploadScreen(
                                        url:
                                            "https://picsum.photos/540/720?random=$index"),
                                  ),
                                );
                              },
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://picsum.photos/540/720?random=$index",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}