import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemButTomLogIn extends StatelessWidget {
  ItemButTomLogIn(
      {this.titleButTom, this.color, this.colorTitle, this.onTap, this.size1});

  final String titleButTom;
  var color;
  var colorTitle;
  final dynamic size1;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.width / 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        alignment: Alignment.center,
        child: Text(
          titleButTom,
          style: TextStyle(
              fontSize: size1, fontWeight: FontWeight.w600, color: colorTitle),
        ),
      ),
    );
  }
}
