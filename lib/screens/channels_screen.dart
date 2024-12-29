import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/screens/channels/ask_screen.dart';
import 'package:nmax/utils/styles.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> allasks;

  @override
  void initState() {
    super.initState();

    allasks = allAsksStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Channels',
        ),
      ),
      body: PageView(
        children: [
          StreamBuilder(
              stream: allasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.hasError ||
                    snapshot.hasData == false)
                  return Center(
                    child: SizedBox(
                      width: AppSizing.getWidth(context) * 0.4,
                      height: 1,
                      child: LinearProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                  );

                if (snapshot.data!.size == 0)
                  return Center(
                    child: SizedBox(
                      width: AppSizing.getWidth(context) * 0.4,
                      height: 1,
                      child: LinearProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                  );
                var asks = snapshot.data!.docs
                    .map(
                      (e) => PostModel.fromJson(e.id, e.data()),
                    )
                    .toList();
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asks[index].caption.toString(),
                              style: AppTypography.body,
                            ),
                            space(10),
                            Wrap(
                              spacing: 10,
                              children: asks[index]
                                  .tags!
                                  .map(
                                    (e) => Container(
                                      child: Text(
                                        e,
                                        style: AppTypography.sub,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.heart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.chat_bubble)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.paperplane)),
                                Spacer(),
                                Text(
                                  asks[index].user.toString(),
                                  style: GoogleFonts.oswald(
                                    color: Colors.deepOrange,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          AskScreen(),
        ],
      ),
    );
  }
}
