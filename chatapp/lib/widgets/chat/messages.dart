import 'package:chatapp/widgets/chat/massage_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Massage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('creatAt', descending: true)
                .snapshots(),
            builder: (ctx, chatsnapshot) {
              if (chatsnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatsDoc = chatsnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, i) => MassageBubble(chatsDoc[i]['text'],
                    chatsDoc[i]['username'],
                    chatsDoc[i]['userImage'],
                    chatsDoc[i]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(chatsDoc[i].documentID),),
                itemCount: chatsDoc.length,
              );
            });
      },
    );
  }
}
