import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nmax/main.dart';
import 'package:nmax/models/chat.dart';

final firestore = FirebaseFirestore.instance;
final authuser = FirebaseAuth.instance.currentUser;

String getConversationID(String name1) {
  String name2 = NavScreen.user;
  return name1.hashCode <= name2.hashCode
      ? '${name1}_${name2}'
      : '${name2}_${name1}';
}

Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessagesStream(String user) {
  return firestore
      .collection('chats/${getConversationID(user)}/messages/')
      .orderBy('sent', descending: true)
      .snapshots();
}

Future<void> sendMessage(String chatUser, String msg, String type) async {
  //message sending time (also used as id)
  final time = DateTime.now().millisecondsSinceEpoch.toString();

  //message to send
  final ChatMessageModel message = ChatMessageModel(
      toId: chatUser,
      msg: msg,
      read: '',
      type: type,
      fromId: NavScreen.user,
      sent: time);

  try {
    final ref =
        firestore.collection('chats/${getConversationID(chatUser)}/messages/');
    await ref.doc(time).set(message.toJson());
    await firestore.collection('users').doc(NavScreen.user).update({
      'direct': FieldValue.arrayUnion([chatUser])
    });
    await firestore.collection('users').doc(chatUser).update({
      'direct': FieldValue.arrayUnion([NavScreen.user])
    });
  } catch (e) {
    rethrow;
  }
}

Future<bool> isNewMessage(String user) async {
  final snap = await firestore
      .collection('chats/${getConversationID(user)}/messages/')
      .orderBy('sent', descending: true)
      .limit(1)
      .get();
  final data = snap.docs.first.data();

  return data['read'].toString().isEmpty &&
      data['fromId'].toString() != NavScreen.user;
}
Future<void> updateMessageReadStatus(ChatMessageModel message) async {
    firestore
        .collection(
            'chats/${getConversationID(message.fromId.toString())}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }