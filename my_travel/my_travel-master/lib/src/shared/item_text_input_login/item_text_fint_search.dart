import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTextSearch extends StatelessWidget {
  ItemTextSearch(
      {this.hintText, this.controller, this.title, this.textInputType});

  final String hintText;
  final String title;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Palette.WHITE,
        border: Border.all(
            width: 1.0,
          color: Palette.COLOR_BORDER2
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Container(
        height: 45,
        child: TextFormField(
          style: TextStyle(
              color: Palette.BLACK,
              fontSize: FontSize.TITLE_ITEM,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: Palette.COLOR_ITEM5,
                fontSize: FontSize.TEXT_DETAIL,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.WHITE),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.WHITE),
            ),
          ),
        ),
      ),
    );
  }
}
