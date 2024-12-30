import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/utils/styles.dart';

class ChannelFeed extends StatefulWidget {
  const ChannelFeed({super.key});

  @override
  State<ChannelFeed> createState() => _ChannelFeedState();
}

class _ChannelFeedState extends State<ChannelFeed> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> allasks;
  late Stream<QuerySnapshot<Map<String, dynamic>>> alltags;

  String selectedChannel = '';

  @override
  void initState() {
    super.initState();

    allasks = allAsksStream(selectedChannel);
    alltags = allChannelTagsStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Channels',
        ),
      ),
      body: StreamBuilder(
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
                            Text(
                              asks[index].likes.toString(),
                              style: AppTypography.body,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.chat_bubble)),
                            Text(
                              asks[index].comments.toString(),
                              style: AppTypography.body,
                            ),
                            Spacer(),
                            Text(
                              asks[index].user.toString(),
                              style: GoogleFonts.oswald(
                                color: Colors.deepOrange,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.paperplane)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      persistentFooterButtons: [
        StreamBuilder(
          stream: alltags,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError ||
                snapshot.hasData == false) return Container();

            List<String> alltags = [];
            snapshot.data!.docs
                .map(
                  (e) => alltags
                      .addAll(List<String>.from(e.data()['tags'] as List)),
                )
                .toList();

            // Step 1: Count occurrences
            Map<String, int> occurrences = {};
            for (String item in alltags) {
              occurrences[item] = (occurrences[item] ?? 0) + 1;
            }

            // Step 2: Sort by occurrences in descending order
            List<String> channels = occurrences.keys.toList()
              ..sort((a, b) => occurrences[b]!.compareTo(occurrences[a]!));

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: channels
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InputChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.black),
                            ),
                            // color: WidgetStateProperty.all(Colors.deepOrange),
                            selectedColor: Colors.deepOrange,
                            checkmarkColor: Colors.white,
                            backgroundColor: Colors.black87,
                            onSelected: (value) {
                              setState(() {
                                selectedChannel = value ? e : '';
                                allasks = allAsksStream(selectedChannel);
                              });
                            },
                            selected: selectedChannel == e,
                            label: Text(
                              e,
                              style: AppTypography.body,
                            )),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
