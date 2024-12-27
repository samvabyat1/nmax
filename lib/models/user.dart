import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String username;
  String email;
  String? picture;
  String? gender;
  String? bio;
  DateTime created;
  bool online;
  List<String> homies;

  UserModel({
    this.name,
    required this.username,
    required this.email,
    this.picture,
    this.gender,
    this.bio,
    required this.created,
    this.online = false,
    List<String>? homies,
  }) : homies = homies ?? [];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name : json['name'],
      username : json['username'] ?? '',
      email : json['email'] ?? '',
      picture : json['picture'],
      gender : json['gender'],
      bio : json['bio'],
      created : (json['created'] as Timestamp).toDate(),
      online : json['online'] ?? false,
      homies : List<String>.from(json['homies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['created'] = this.created;
    data['online'] = this.online;
    data['homies'] = this.homies;
    return data;
  }
}
