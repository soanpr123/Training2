import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemButTomLogIn2 extends StatelessWidget {
  ItemButTomLogIn2({this.titleButTom, this.onTap,this.icon});

  final String titleButTom;
   dynamic icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width / 2.7,
        height: 40,
        
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Palette.WHITE,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(icon),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                titleButTom,
                style: TextStyle(
                    fontSize: FontSize.TITLE_LOGIN3,
                    fontWeight: FontWeight.bold,
                    color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN2,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
