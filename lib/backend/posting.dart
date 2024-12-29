import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/models/user.dart';

final firestore = FirebaseFirestore.instance;
final authuser = FirebaseAuth.instance.currentUser;

Future<void> uploadPost(String username, Uint8List bytes) async {
  UserModel? user = await getUser(username);

  if (user != null) {
    await firestore.collection('posts').add(PostModel(
          user: user.username,
          id: '',
          comments: 0,
          likes: 0,
          likedby: [],
          url: '',
          created: DateTime.now(),
        ).toJson());
  }
}

Future<void> sendChannelAsk(String ask, List<String> tags) async {
  var username = await getUsernameFromEmail();
  await firestore.collection('ask').add(PostModel(
        user: username,
        id: '',
        comments: 0,
        likes: 0,
        likedby: [],
        url: '',
        caption: ask,
        tags: tags.toSet().union(extractTags(ask).toSet()).toList(),
        created: DateTime.now(),
      ).toJson());
}

List<String> extractTags(String description) {
  final RegExp hashtagRegExp = RegExp(r'#\w+');
  return hashtagRegExp
      .allMatches(description)
      .map((match) => match.group(0)!)
      .toList();
}
