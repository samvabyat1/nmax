// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:nmax/models/news.dart';
import 'package:nmax/models/photo.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/models/user.dart';

final firestore = FirebaseFirestore.instance;

Future<void> testAddApiUsers() async {
  final ref = firestore.collection('users');

  var res = await http.get(Uri.parse('https://dummyjson.com/users'));

  var data = jsonDecode(res.body.toString())['users'];

  if (res.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      await ref.doc(i['username']).set(UserModel(
              username: i['username'],
              email: i["firstName"],
              created: DateTime.now())
          .toJson());
    }
  }
}

Future<List<PhotoModel>> getPhotos(int limit) async {
  var res = await http
      .get(Uri.parse('https://picsum.photos/v2/list?page=2&limit=$limit'));

  var data = jsonDecode(res.body.toString());

  List<PhotoModel> list = [];

  if (res.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      list.add(PhotoModel.fromJson(i));
    }
  }
  return list;
}

Future<List<NewsModel>> getNews() async {
  var res = await http.get(Uri.parse(
      'https://saurav.tech/NewsAPI/top-headlines/category/business/in.json'));

  var data = jsonDecode(res.body.toString())['articles'];

  List<NewsModel> list = [];

  if (res.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      list.add(NewsModel.fromJson(i));
      print(i['title']);
    }
  }
  return list;
}

Future<void> testAddApiPosts() async {
  await firestore
      .collection('users')
      .where('username', isNotEqualTo: 'samvabya')
      .get()
      .then((snapshot) async {
    for (var i = 0; i < 30; i++) {
      try {
        await firestore.collection('posts').add(PostModel(
              id: '',
              created: DateTime.now(),
              likes: 0,
              likedby: [],
              caption: '',
              comments: 0,
              tags: [],
              url: "https://picsum.photos/360/480?random=${i + 30}",
              thumb: '',
              user: snapshot.docs.elementAt(i).id,
              userpic: '',
            ).toJson());
        print(snapshot.docs.elementAt(i).id + ' ✓');
      } catch (e) {
        print(snapshot.docs.elementAt(i).id + ' X');
      }
    }
  });
}

Future<void> getAllPosts() async {
  await firestore
      .collection('posts')
      .get()
      .then((snapshot) {
    print(snapshot.size);
  });
}
