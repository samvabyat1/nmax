import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nmax/backend/chating.dart';
import 'package:nmax/models/chat.dart';
import 'package:nmax/models/user.dart';
import 'package:nmax/screens/direct/chat_widgets.dart';
import 'package:nmax/utils/outputs.dart';
import 'package:nmax/utils/styles.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> messagesData;
  final textContronller = TextEditingController();

  @override
  void initState() {
    super.initState();

    messagesData = getAllMessagesStream(widget.user.username);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isdesk = AppSizing.getWidth(context) > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.user.username),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        // fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Visibility(
              visible: !isdesk,
              child: Image.network(
                'https://picsum.photos/720/540',
                fit: BoxFit.fitWidth,
                color: Colors.redAccent,
                colorBlendMode: BlendMode.softLight,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.only(top: isdesk ? 0 : 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: isdesk ? Radius.zero : Radius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: SweepGradient(
                        colors: [Color(0xffeb5757), Color(0xff000000)],
                        stops: [0, 1],
                        center: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            Expanded(
                              child: StreamBuilder(
                                  stream: messagesData,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        snapshot.hasError ||
                                        snapshot.hasData == false)
                                      return Center(
                                        child: SizedBox(
                                          width:
                                              AppSizing.getWidth(context) * 0.4,
                                          height: 1,
                                          child: LinearProgressIndicator(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      );

                                    final data = snapshot.data?.docs;
                                    List<ChatMessageModel> list = data
                                            ?.map((e) =>
                                                ChatMessageModel.fromJson(
                                                    e.data()))
                                            .toList() ??
                                        [];

                                    if (list.isEmpty)
                                      return Center(
                                          child: SizedBox(
                                        width:
                                            AppSizing.getWidth(context) * 0.6,
                                        child: SvgPicture.asset(
                                          'assets/ph1.svg',
                                        ),
                                      ));

                                    return ListView.builder(
                                      itemCount: list.length,
                                      reverse: true,
                                      itemBuilder: (context, index) =>
                                          normalTextTile(list[index], context),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: AppSizing.getWidth(context) * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: TextField(
                                    controller: textContronller,
                                    style: AppTypography.body,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Say hiii...',
                                      hintStyle: AppTypography.sub,
                                    ),
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        try {
                                          sendMessage(
                                              widget.user.username, value, '');
                                          setState(() {
                                            textContronller.clear();
                                          });
                                        } catch (e) {
                                          showSnack(context, 'Error $e');
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
