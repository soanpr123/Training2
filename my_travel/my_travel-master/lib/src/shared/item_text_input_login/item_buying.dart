import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemBuying extends StatelessWidget {
  ItemBuying({this.hint});

  StreamController _validate = StreamController();

  Stream get validate => _validate.stream;

  dispose() {
    _validate.close();
  }

  final String hint;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 55,
      width: size.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: Palette.WHITE,
          border: Border.all(color: Palette.COLOR_TITE4, width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Palette.COLOR_TITE6,
              fontSize: FontSize.HINT_SIZE_LOGIN,
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
    );
  }
}
