// ignore_for_file: unused_field

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/screens/post/matrixgd.dart';
import 'package:nmax/utils/styles.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PostUploadScreen extends StatefulWidget {
  final Uint8List? bytes;
  const PostUploadScreen({super.key, required this.bytes});

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  var _textController = TextEditingController();
  var _widgetController = WidgetsToImageController();

  FontWeight fw = FontWeight.bold;
  var szi = 0;
  List<double> sz = [20, 30, 50];
  Color cl = Colors.black;
  var fsi = 0;
  var fs = [
    'Permanent Marker',
    'Comic Neue',
    'Nothing You Could Do',
    'Oswald',
    'Poppins',
    'Roboto Mono',
    'Merriweather',
  ];

  openTextEditor() => showDialog(
        context: context,
        builder: (context) => Material(
          color: Colors.black26,
          child: Center(
            child: SizedBox(
              width: AppSizing.getWidth(context) * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(CupertinoIcons.check_mark)),
                    ],
                  ),
                  TextField(
                    maxLines: 2,
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _textController;
                      });
                    },
                    textCapitalization: TextCapitalization.words,
                    style: AppTypography.body,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Caption',
                      hintStyle: AppTypography.sub,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();

    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.memory(
                      widget.bytes!,
                      fit: BoxFit.cover,
                    ),
                    MatrixGD(
                      child: Text(
                        textAlign: TextAlign.center,
                        _textController.text.trim(),
                        style: GoogleFonts.getFont(
                          fs[fsi],
                          color: cl,
                          fontWeight: fw,
                          fontSize: sz[szi],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        szi = szi == sz.length - 1 ? 0 : szi + 1;
                      });
                    },
                    icon: Icon(CupertinoIcons.textformat_size)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        cl = cl == Colors.white ? Colors.black : Colors.white;
                      });
                    },
                    icon: Icon(CupertinoIcons.color_filter)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        fsi = fsi == fs.length - 1 ? 0 : fsi + 1;
                      });
                    },
                    icon: Icon(CupertinoIcons.text_cursor)),
                Spacer(),
                IconButton(
                  onPressed: () => openTextEditor(),
                  icon: Icon(CupertinoIcons.textformat),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
