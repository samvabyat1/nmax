import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nmax/models/user.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final firestore = FirebaseFirestore.instance;

Stream<QuerySnapshot<Map<String, dynamic>>> allPostsStream() {
  return firestore.collection('posts').snapshots();
}

Future<File> fileFromImageUrl(String url) async {
  final response = await http.get(Uri.parse(url));

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, 'imagetest.png'));

  file.writeAsBytesSync(response.bodyBytes);

  return file;
}

Future<UserModel?> getUser(String email) async {
  var data = await firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  if (data.size > 0) return UserModel.fromJson(data.docs.first.data());

  return null;
}


  Future<Color> getImagePalette(String url) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(url));
    return paletteGenerator.dominantColor!.color;
  }
