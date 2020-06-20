import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTextInformation extends StatelessWidget {
  ItemTextInformation({this.hintText, this.controller, this.title,this.textInputType});

  final String hintText;
  final String title;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "$title:",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Palette.COLOR_TITLE_FLIGHTS2),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.fromLTRB(size.width / 30, 0, 0, 0),
              child: TextFormField(
                controller: controller,
                keyboardType: textInputType,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.TEXT_2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.TEXT_2),
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: FontSize.HINT_SIZE_LOGIN,
                        color: Palette.HINT_COLOR_LOGIN),
                    labelStyle: TextStyle(
                        fontSize: FontSize.HINT_SIZE_LOGIN,
                        color: Palette.HINT_COLOR_LOGIN)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
