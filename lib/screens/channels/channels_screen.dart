import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/screens/channels/ask_screen.dart';
import 'package:nmax/screens/channels/channel_feed.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
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
      body: PageView(
        children: [
          ChannelFeed(),
          AskScreen(),
        ],
      ),
    );
  }
}
