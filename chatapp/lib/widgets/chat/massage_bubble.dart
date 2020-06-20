import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MassageBubble extends StatelessWidget {
  final String massage;
  final bool isMe;
  final String userName;
  final String userurl;
  final Key key;
  MassageBubble(this.massage, this.userName, this.userurl, this.isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.lightBlue : Colors.grey[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.red : Colors.black,
                        fontSize: 18),
                  ),
                  Text(
                    massage,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 18),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            right: isMe ? 120 : null,
            left: isMe ? null : 120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userurl),
            )),
      ],
    );
  }
}
