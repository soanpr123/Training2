import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title, this.icon, this.onPressed, this.onPressed2});

  final String title;
  final String icon;
  final VoidCallback onPressed;
  final VoidCallback onPressed2;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Palette.BLACK,
            ),
            onPressed: onPressed,
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            padding: const EdgeInsets.only(
                left: 30.0, right: 30, top: 17.0, bottom: 17.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: FontSize.TITLE_LOGIN2,
                  fontWeight: FontWeight.bold,
                  color: Palette.COLOR_TITLE_FLIGHTS),
            ),
          ),
          InkWell(
            onTap: onPressed2,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Image.asset(
              icon,
              width: 20,
            )),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Palette.COLOR_BORDER_TEXTF,
          width: 0.3,
        ),
      )),
    );
  }
}
