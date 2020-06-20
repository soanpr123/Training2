import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemOr extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Row(
				children: <Widget>[
					Expanded(
						flex: 1,
						child: Container(
							margin: EdgeInsets.fromLTRB(43, 0, 4, 0),
							height: 0.8,
							color: Palette.WHITE,
						),
					),
					Expanded(
						flex: 0,
						child: Text(
							"hoặc",
							style: TextStyle(
									fontSize: FontSize.TITLE_STATUS_TIME,
									color: Palette.WHITE),
						),
					),
					Expanded(
						flex: 1,
						child: Container(
							margin: EdgeInsets.fromLTRB(4, 0, 43, 0),
							height: 0.8,
							color: Palette.WHITE,
						),
					)
				],
			),
		);
	}
}
