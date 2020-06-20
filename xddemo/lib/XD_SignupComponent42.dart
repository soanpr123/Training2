import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class XD_SignupComponent42 extends StatelessWidget {
  XD_SignupComponent42({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0.0, 28.5),
          child: SvgPicture.string(
            _shapeSVG_a8455b89dad24b0fab8a39c17233767d,
            allowDrawingOutsideViewBox: true,
          ),
        ),
        Transform.translate(
          offset: Offset(-92.0, -494.0),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(96.0, 493.5),
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: const Color(0x662e2e2e),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Transform.translate(
                offset: Offset(96.0, 494.0),
                child: Container(
                  width: 84.0,
                  height: 19.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(-92.0, -494.0),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(96.0, 493.5),
                child: Text(
                  'nikhil123',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: const Color(0xff2e2e2e),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Transform.translate(
                offset: Offset(92.0, 494.0),
                child: Container(
                  width: 4.0,
                  height: 19.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const String _shapeSVG_a8455b89dad24b0fab8a39c17233767d =
    '<svg viewBox="0.0 28.5 239.0 1.0" ><path transform="translate(0.0, 28.5)" d="M 0 0 L 239 0" fill="none" fill-opacity="0.2" stroke="#000000" stroke-width="2" stroke-opacity="0.2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
