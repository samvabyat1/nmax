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

Future<void> toggleLike(String post) async {
  String userId = await getUsernameFromEmail();
  try {
    final postRef = firestore.collection('posts').doc(post);

    final postSnapshot = await postRef.get();
    if (!postSnapshot.exists) {
      throw Exception('Post does not exist');
    }
    final currentLikes = postSnapshot.get('likes') ?? 0;
    final likedBy = List<String>.from(postSnapshot.data()?['likedBy'] ?? []);

    if (likedBy.contains(userId)) {
      // Only decrement if likes > 0
      if (currentLikes > 0) {
        postRef.update({
          'likes': currentLikes - 1,
          'likedBy': FieldValue.arrayRemove([userId]),
        });
      } else {
        // Just remove from likedBy without decrementing
        postRef.update({
          'likedBy': FieldValue.arrayRemove([userId]),
        });
      }
    } else {
      postRef.update({
        'likes': currentLikes + 1,
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    }
    await firestore.runTransaction((transaction) async {});
  } catch (e) {
    print(e.toString());
  }
}
