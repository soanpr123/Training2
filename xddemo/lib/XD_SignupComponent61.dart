import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class XD_SignupComponent61 extends StatelessWidget {
  XD_SignupComponent61({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 17.0,
          height: 17.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: const Color(0x1d000000),
          ),
        ),
        Transform.translate(
          offset: Offset(7.5, 7.5),
          child: Container(
            width: 2.0,
            height: 2.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: const Color(0x0000b4ac),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(33.0, 1.0),
          child: Text(
            'I have accepted the',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: const Color(0x66000000),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Transform.translate(
          offset: Offset(161.0, 1.0),
          child: Text(
            'Terms & Condition',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: const Color(0xff00b4ac),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Transform.translate(
          offset: Offset(161.5, 17.5),
          child: SvgPicture.string(
            _shapeSVG_42d2d3b92bef431d902943fe033603ac,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ],
    );
  }
}

const String _shapeSVG_42d2d3b92bef431d902943fe033603ac =
    '<svg viewBox="161.5 17.5 117.0 1.0" ><path transform="translate(161.5, 17.5)" d="M 0 0 L 117 0" fill="none" stroke="#00b4ac" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
