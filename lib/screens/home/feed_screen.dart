import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nmax/backend/home.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/utils/styles.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> allposts;

  @override
  void initState() {
    super.initState();

    allposts = allPostsStream();
  }

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
                      'Hey',
                      style: AppTypography.h1,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/technology.png',
                        width: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/icon.png',
                        // color: Colors.white,
                        width: 35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'FEATURED',
                    style: AppTypography.sub,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: false,
                child: SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(left: 15),
                          itemCount: 20,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SizedBox(
                                width: 135,
                                child: Card(
                                  color: Colors.deepPurple[300],
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    "https://picsum.photos/200?random=$index",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  // height: AppSizing.getHeight(context) * 0.45,
                  width: double.maxFinite,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: StreamBuilder(
                        stream: allposts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.hasError ||
                              snapshot.hasData == false)
                            return CardSwiper(
                              padding: EdgeInsets.all(5),
                              cardsCount: 2,
                              cardBuilder: (context,
                                  index,
                                  horizontalOffsetPercentage,
                                  verticalOffsetPercentage) {
                                return Card(
                                  color: Colors.deepPurple[300],
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://picsum.photos/1080?random=$index",
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );

                          return CardSwiper(
                            padding: EdgeInsets.all(5),
                            cardsCount: snapshot.data!.size,
                            cardBuilder: (context,
                                index,
                                horizontalOffsetPercentage,
                                verticalOffsetPercentage) {
                              var post = PostModel.fromJson(
                                  snapshot.data!.docs[index].data());
                              return Stack(
                                children: [
                                  Card(
                                    color: Colors.deepPurple[300],
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          post.url ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/icon.png',
                                            color: Colors.white,
                                            colorBlendMode: BlendMode.color,
                                            width: 30,
                                          ),
                                        ),
                                        space(10),
                                        Text(
                                          post.user ?? 'nmax user',
                                          style: AppTypography.h6oi,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },),
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
