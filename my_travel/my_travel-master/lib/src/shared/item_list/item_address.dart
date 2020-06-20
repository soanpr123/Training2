import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemAddress extends StatelessWidget {
	ItemAddress({this.title,this.onTap});
	
	final String title;
	final VoidCallback onTap;
	
	@override
	Widget build(BuildContext context) {
		Size size = MediaQuery.of(context).size;
		return InkWell(
			onTap: onTap,
			child: Container(
				color: Palette.WHITE,
			  child: Column(
			  	crossAxisAlignment: CrossAxisAlignment.start,
			    children: <Widget>[
			      Container(
			      	
			      	padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
			      	child: Text(title),
			      ),
			  	  Container(
			  		  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
			  		  height: 0.5,
			  		  color: Palette.COLOR_BORDER,
			  		  width: size.width,
			  	  )
			    ],
			  ),
			),
		);
	}
}
