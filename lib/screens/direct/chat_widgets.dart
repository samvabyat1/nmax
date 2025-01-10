import 'package:flutter/material.dart';
import 'package:nmax/backend/chating.dart';
import 'package:nmax/navscreen.dart';
import 'package:nmax/models/chat.dart';
import 'package:nmax/utils/styles.dart';

Widget geminiTextTile(String text, BuildContext context, bool me) {
  return Row(
    mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: AppSizing.getWidth(context) * 0.8),
          child: Container(
            decoration: BoxDecoration(
              color: me ? Colors.pinkAccent : Colors.grey[900],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: AppTypography.body,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget normalTextTile(ChatMessageModel chat, BuildContext context) {
  bool me = chat.fromId == NavScreen.user;

  return Row(
    mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: me ? rightText(chat, context) : leftText(chat, context),
      ),
    ],
  );
}

Widget leftText(ChatMessageModel chat, BuildContext context) {
    if (chat.read!.isEmpty) {
      updateMessageReadStatus(chat);
    }
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: AppSizing.getWidth(context) * 0.8),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Text(
          chat.msg.toString(),
          style: AppTypography.body,
        ),
      ),
    ),
  );
}

Widget rightText(ChatMessageModel chat, BuildContext context) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: AppSizing.getWidth(context) * 0.8),
    child: Container(
      decoration: BoxDecoration(
        color: chat.read!.isNotEmpty
            ? Colors.redAccent
            : Colors.redAccent.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Text(
          chat.msg.toString(),
          style: AppTypography.body,
        ),
      ),
    ),
  );
}
