// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nmax/backend/getting.dart';
import 'package:nmax/models/user.dart';
import 'package:nmax/screens/profile/profile_desk.dart';
import 'package:nmax/screens/profile/profile_mobile.dart';
import 'package:nmax/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  ProfileScreen({
    super.key,
    this.username = '',
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel? user;
  final authuser = FirebaseAuth.instance.currentUser;
  bool isOwnProfile = false;

  Color cardcolor = Colors.grey;

  void getCardColor() async {
    cardcolor = await getImagePalette(user!.picture == null
        ? authuser!.photoURL.toString()
        : user!.picture.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    isOwnProfile = widget.username == '';
    // getCardColor();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(widget.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              snapshot.hasData == false) return Scaffold();

          user = snapshot.data;

          // getCardColor();

          if (AppSizing.getWidth(context) > 1000)
            return profileDesk(user, isOwnProfile, context);

          return profileMobile(user, isOwnProfile, context);
        });
  }
}
