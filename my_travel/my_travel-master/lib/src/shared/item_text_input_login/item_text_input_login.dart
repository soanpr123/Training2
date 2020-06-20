import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTextInputLogin extends StatelessWidget {
  ItemTextInputLogin({this.hintText, this.controller, this.index});

  final String hintText;
  final TextEditingController controller;
  int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: size.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        color: Palette.ITEM_TEXT_COLOR,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Form(
        child: TextFormField(
          controller: controller,
          obscureText: index == 0 ? true : false,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.ITEM_TEXT_COLOR),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.ITEM_TEXT_COLOR),
            ),
            hintText: hintText,
            hintStyle:
                TextStyle(fontSize: FontSize.HINT_SIZE_LOGIN, color: Palette.HINT_COLOR_LOGIN),
            labelStyle:
                TextStyle(fontSize: FontSize.HINT_SIZE_LOGIN, color: Palette.HINT_COLOR_LOGIN),
          ),
        ),
      ),
    );
  }
}
