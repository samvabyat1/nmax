import 'package:flutter/material.dart';
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
