import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemSearchFlights2 extends StatelessWidget {
  ItemSearchFlights2(
      {this.hintText, this.controller, this.title, this.textInputType});

  final String hintText;
  final String title;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 6.2,
      padding: EdgeInsets.fromLTRB(20, 4.5, 20, 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          color: Palette.COLOR_TAB1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: size.width / 14,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                  color: Palette.COLOR_BORDER_TEXTF,
                  fontSize: FontSize.TEXT_ITEM_HOTEL,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
            ),
          ),
          Container(
            height: size.width / 14,
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
                    color: Palette.COLOR_BORDER_TEXTF,
                    fontSize: FontSize.TEXT_DETAIL,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.COLOR_TAB1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.COLOR_TAB1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
