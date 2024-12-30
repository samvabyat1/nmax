// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:nmax/backend/posting.dart';
import 'package:nmax/models/news.dart';
import 'package:nmax/models/photo.dart';
import 'package:nmax/models/post.dart';
import 'package:nmax/models/user.dart';

final firestore = FirebaseFirestore.instance;

List<String> nmaxQuestions = [
  // General App Features
  "What are the unique features of NMax compared to other social media platforms? #nmax #general",
  "How does the end-to-end encryption work in NMax? #nmax #security",
  "Is there a subscription model or are the services free to use? #nmax #general",
  "What platforms are supported by NMax (e.g., Android, iOS, Web)? #nmax #general",
  "How does NMax ensure data privacy and security for users? #nmax #security",
  
  // Photo Story
  "Can users add music to their photo stories in NMax? #nmax #photostory",
  "What customization options are available for creating photo stories? #nmax #photostory",
  "How long are photo stories visible to other users? #nmax #photostory",
  "Are there filters or AR effects in NMax's photo story feature? #nmax #photostory",
  "Is it possible to save photo stories to a personal archive? #nmax #photostory",
  
  // Community Posting
  "How are communities moderated on NMax? #nmax #community",
  "Can users create private communities on NMax? #nmax #community",
  "What types of content can be shared in community posts? #nmax #community",
  "Does NMax allow polls or surveys in community posts? #nmax #community",
  "Are there limits on the number of members in a community? #nmax #community",
  
  // Direct Personal Messaging
  "Can users send multimedia messages through NMax? #nmax #messaging",
  "What features are included in NMax's chat functionality? #nmax #messaging",
  "Does NMax support group chats in direct messaging? #nmax #messaging",
  "Are messages on NMax retrievable after deletion? #nmax #messaging",
  "Is there a 'read receipt' feature in NMax messaging? #nmax #messaging",
  
  // Shopping
  "What categories of products are available in NMax's shopping feature? #nmax #shopping",
  "Can users sell their own products on NMax? #nmax #shopping",
  "How does NMax handle payment processing for purchases? #nmax #shopping",
  "Is there a rating and review system for sellers on NMax? #nmax #shopping",
  "What delivery options are available for shopping on NMax? #nmax #shopping",
  
  // News and Content Watching
  "What types of news sources are integrated into NMax? #nmax #news",
  "Can users personalize their news feed on NMax? #nmax #news",
  "What video formats are supported for content watching? #nmax #contentwatching",
  "Does NMax recommend content based on user preferences? #nmax #contentwatching",
  "Are there parental controls for content watching in NMax? #nmax #contentwatching",
  
  // Payments, Trading, and Crypto
  "What payment methods are supported on NMax? #nmax #payments",
  "Can users trade items directly with others on NMax? #nmax #trading",
  "How does the crypto feature work in NMax? #nmax #crypto",
  "Does NMax provide a wallet for storing digital assets? #nmax #crypto",
  "Are there fees associated with crypto transactions on NMax? #nmax #crypto"
];


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
    for (var i = 0; i < nmaxQuestions.length; i++) {
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
              user: snapshot.docs.elementAt(Random().nextInt(30)).id,
              userpic: '',
            ).toJson());
        print('$i ✓');
      } catch (e) {
        print('$i X');
      }
    }
  });
}

Future<void> testAddMannualAsks() async {
  await firestore
      .collection('users')
      .where('username', isNotEqualTo: 'samvabya')
      .get()
      .then((snapshot) async {
    for (var i = 0; i < 30; i++) {
      try {
        await firestore.collection('ask').add(PostModel(
              id: '',
              created: DateTime.now(),
              likes: Random().nextInt(1000),
              likedby: [],
              caption: nmaxQuestions[i],
              comments: 0,
              tags: extractTags(nmaxQuestions[i]),
              url: '',
              user: snapshot.docs.elementAt(i).id,
            ).toJson());
        print(snapshot.docs.elementAt(i).id + ' ✓');
      } catch (e) {
        print(snapshot.docs.elementAt(i).id + ' X');
      }
    }
  });
}

Future<void> getAllPosts() async {
  await firestore.collection('posts').get().then((snapshot) {
    print(snapshot.size);
  });
}
