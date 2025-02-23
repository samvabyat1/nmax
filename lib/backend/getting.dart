import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/models/user.dart';
import 'package:palette_generator/palette_generator.dart';

final firestore = FirebaseFirestore.instance;

Stream<QuerySnapshot<Map<String, dynamic>>> allPostsStream() {
  return firestore
      .collection('posts')
      .orderBy('created', descending: true)
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> allAsksStream(String channel) {
  if (channel.isNotEmpty)
    return firestore
        .collection('ask')
        .where('tags', arrayContains: channel)
        .orderBy('created', descending: true)
        .snapshots();
  return firestore
      .collection('ask')
      .orderBy('created', descending: true)
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> allChannelTagsStream() {
  return firestore.collection('ask').orderBy('tags').snapshots();
}

Future<Color> getImagePalette(String url) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(NetworkImage(url));
  return paletteGenerator.dominantColor!.color;
}

Future<UserModel?> getUser(String username) async {
  var data;
  if (username.isEmpty) {
    data = await firestore
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
  } else {
    data = await firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
  }
  if (data.size > 0) return UserModel.fromJson(data.docs.first.data());

  return null;
}

Future<List<PostModel>> getUserPosts(String username) async {
  var data = await firestore
      .collection('posts')
      .where('user', isEqualTo: username)
      .get();

  if (data.size == 0) return [];
  return data.docs
      .map(
        (e) => PostModel.fromJson(e.id, e.data()),
      )
      .toList();
}

Future<String> getUsernameFromEmail() async {
  var email = FirebaseAuth.instance.currentUser!.email;
  var data = await firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  return data.docs.first.id;
}
