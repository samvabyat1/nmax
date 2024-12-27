import 'package:flutter/material.dart';

class PostUploadScreen extends StatefulWidget {
  final String url;
  const PostUploadScreen({super.key, required this.url});

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
