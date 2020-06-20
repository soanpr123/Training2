import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagepickFn);
  final void Function(File pikerImage)imagepickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pikerImages;
  void _pikerImage() async {
    final pickedImage = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
    setState(() {
      _pikerImages = pickedImage;
    });
    widget.imagepickFn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pikerImages != null ? FileImage(_pikerImages) : null,
        ),
        FlatButton.icon(
            onPressed: _pikerImage,
            icon: Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
            ),
            label: Text(
              "Add Image",
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
      ],
    );
  }
}
