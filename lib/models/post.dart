import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? url;
  String? thumb;
  String? user;
  String? userpic;
  DateTime? created;
  String? caption;
  int? likes;
  List<String>? likedby;
  int? comments;
  List<String>? tags;

  PostModel(
      {this.id,
      this.url,
      this.thumb,
      this.user,
      this.userpic,
      this.created,
      this.caption,
      this.likes,
      this.likedby,
      this.comments,
      this.tags});

  PostModel.fromJson(String id, Map<String, dynamic> json) {
    id = id;
    url = json['url'];
    thumb = json['thumb'];
    user = json['user'];
    userpic = json['userpic'];
    created=(json['created'] as Timestamp).toDate();
    caption = json['caption'];
    likes = json['likes'];
    likedby = json['likedby'].cast<String>();
    comments = json['comments'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    data['user'] = this.user;
    data['userpic'] = this.userpic;
    data['created'] = this.created;
    data['caption'] = this.caption;
    data['likes'] = this.likes;
    data['likedby'] = this.likedby;
    data['comments'] = this.comments;
    data['tags'] = this.tags;
    return data;
  }
}
