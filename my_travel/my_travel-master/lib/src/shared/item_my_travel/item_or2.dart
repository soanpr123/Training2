import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemOr2 extends StatelessWidget {
	
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
							color: Palette.COLOR_BORDER_TEXTF,
						),
					),
					Expanded(
						flex: 0,
						child: Text(
							"Thời gian dừng 1h15m",
							style: TextStyle(
									fontSize: FontSize.TITLE_STATUS_TIME,
									color: Palette.COLOR_BORDER_TEXTF),
						),
					),
					Expanded(
						flex: 1,
						child: Container(
							margin: EdgeInsets.fromLTRB(4, 0, 43, 0),
							height: 0.8,
							color: Palette.COLOR_BORDER_TEXTF,
						),
					)
				],
			),
		);
	}
}
