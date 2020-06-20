import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_text_information.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/sign_in_screen/menu_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  DatumLogin datumLogin = DatumLogin();

  InformationScreen({this.datumLogin});
  @override
  State createState() => new _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  double _value = 25.0;
  bool _lights = false;
  bool _lights1 = false;
  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 30, size.width / 35, 0),
                child: ItemTextInformation(
                  hintText: widget.datumLogin.name,
                  textInputType: TextInputType.text,
                  title: "Name",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 30, size.width / 35, 0),
                child: ItemTextInformation(
                  hintText: "Ngách 42, Ngõ 58, Nguyễn Khánh Toàn, Cầu Giấy, Hà Nội",
                  textInputType: TextInputType.text,
                  title: "Location",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 30, size.width / 35, 0),
                child: ItemTextInformation(
                  hintText: "Phone...",
                  textInputType: TextInputType.number,
                  title: "Phone",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 30, size.width / 35, 0),
                child: ItemTextInformation(
                  hintText: widget.datumLogin.email,
                  textInputType: TextInputType.number,
                  title: "Email",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 10, size.width / 35, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Bank card",
                      style: TextStyle(
                          fontSize: FontSize.ITEM_STAR_BANNER,
                          fontWeight: FontWeight.w500,
                          color: Palette.COLOR_BORDER_TEXTF),
                    ),
                    ItemTextInformation(
                      hintText: "ATM...",
                      textInputType: TextInputType.number,
                      title: "ATM",
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width / 35, size.width / 10, size.width / 35, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: MaterialButton(
                            color: Colors.blue,
                            child: Text(
                              "Đăng xuất",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async{
                              sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.remove("user_name");
                              sharedPreferences.remove("password");
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: MaterialButton(
                            color: Colors.blue,
                            child: Text(
                              "Lưu thông tin",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
