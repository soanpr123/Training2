import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMassage extends StatefulWidget {
  @override
  _NewMassageState createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {
  final _controler=new TextEditingController();
  var _enteredMessage='';
  void _sendMassage() async{
    FocusScope.of(context).unfocus();
   final user= await FirebaseAuth.instance.currentUser();
   final userData=await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text':_enteredMessage,
      'creatAt':Timestamp.now(),
      'userId':user.uid,
      'username':userData['username'],
      'userImage':userData['image_url']
    });
_controler.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                controller: _controler,
            decoration: InputDecoration(
              labelText: 'send massage....',
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage=value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty? null : _sendMassage
          )
        ],
      ),
    );
  }
}
