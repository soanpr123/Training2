import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_text_input_login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ResetsYourPasswordScreen extends StatefulWidget{
	@override
	State createState() => new _ResetsYourPasswordScreenState();
}

class _ResetsYourPasswordScreenState extends State<ResetsYourPasswordScreen> {
	
	TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
	  Size size = MediaQuery.of(context).size;
    return Scaffold(
	    backgroundColor: Palette.WHITE,
	    body: Container(
		    margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
		    child: Column(
			    mainAxisAlignment: MainAxisAlignment.center,
			    children: <Widget>[
				    Expanded(
						    flex: 0,
						    child: Container(
							    alignment: Alignment.centerLeft,
							    height: 40,
							    width: size.width,
							    child: IconButton(
									    icon: Icon(
										    Icons.arrow_back,
										    color: Palette.COLOR_ICON_APBAR,
									    ),
									    onPressed: () {
										    Navigator.pop(context);
									    }),
						    )),
				    Expanded(
					    flex: 5,
					    child: SingleChildScrollView(
						    child: Container(
							    margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
							    child: Column(
								    children: <Widget>[
									    Container(
										    alignment: Alignment.center,
										    child: Text(
											    "Reset Your Password",
											    textAlign: TextAlign.center,
											    style: TextStyle(
													    color: Palette.BLACK,
													    fontSize: FontSize.TITLE2,
													    fontWeight: FontWeight.w400),
										    ),
									    ),
									    Container(
											    margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
											    child: ItemTextInputLogin(
												    hintText: "Email address",
												    controller: _emailController,
											    )),
									    Container(
										    margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
										    child: ItemButTomLogIn(
												    titleButTom: "RESET YOUR PASSWORD",
												    color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
												    size1: FontSize.TITLE_LOGIN4,
												    colorTitle: Palette.WHITE),
									    ),
								    ],
							    ),
						    ),
					    ),
				    ),
			    ],
		    ),
	    ),
    );
  }
}