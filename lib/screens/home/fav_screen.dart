import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/screens/post/post_upload_screen.dart';
import 'package:nmax/utils/styles.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

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
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: CardSwiper(
                          padding: EdgeInsets.all(5),
                          cardsCount: 20,
                          cardBuilder: (context,
                              index,
                              horizontalOffsetPercentage,
                              verticalOffsetPercentage) {
                            var _controller = WidgetsToImageController();

                            return WidgetsToImage(
                              controller: _controller,
                              child: Card(
                                color: Colors.pink[300],
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Center(
                                          child: SizedBox(
                                            width: AppSizing.getWidth(context) *
                                                0.4,
                                            height: 1,
                                            child: LinearProgressIndicator(),
                                          ),
                                        ),
                                      );
                                      final bytes = await _controller.capture();

                                      Navigator.pop(context);

                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              PostUploadScreen(bytes: bytes),
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
                              ),
                            );
                          },
                        ),
                      ),
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
