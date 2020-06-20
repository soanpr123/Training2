import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemButTomconfirm extends StatelessWidget {
	ItemButTomconfirm(
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
				height: size.width / 9,
				decoration: BoxDecoration(
					color: Palette.BACKGROUND_COLOR_SKFC,
					borderRadius: BorderRadius.all(Radius.circular(4.0)),
				),
				alignment: Alignment.center,
				child: Text(
					titleButTom,
					style: TextStyle(
							fontSize: FontSize.TITLE_LOGIN, fontWeight: FontWeight.w600, color: Palette.WHITE),
				),
			),
		);
	}
}
