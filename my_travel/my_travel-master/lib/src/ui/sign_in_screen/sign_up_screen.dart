import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_text_input_login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/shared/toast.dart';
import 'package:my_travel/src/ui/sign_in_screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

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
                          "Create New Account",
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
                            hintText: "Username",
                            controller: _nameController,
                            index: 1,
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                          child: ItemTextInputLogin(
                            hintText: "Email Address",
                            controller: _emailController,
                            index: 2,
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                          child: ItemTextInputLogin(
                            hintText: "Password",
                            controller: _passController,
                            index: 0,
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: ItemButTomLogIn(
                          titleButTom: "SIGN UP",
                          color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                          size1: FontSize.TITLE_LOGIN,
                          colorTitle: Palette.WHITE,
                          onTap: () async {
                            if (_nameController.text.trim().length > 6) {
                              if (_emailController.text.contains("@") &&
                                  _emailController.text.trim().length > 6) {
                                if (_passController.text.length > 6) {
                                  await LoginService().resign(
                                      username: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passController.text.trim(),
                                      urlAvatar: null,
                                      successBloc: (data) {
                                        Fluttertoast.showToast(
                                            msg: "Đăng ký thành công",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIos: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => SignIn()));
                                        return;
                                      },
                                      failBloc: (err) {
                                        return;
                                      });
                                } else {
                                  ToastShare().getToast("Mật khẩu phải hơn 6 ký tự");
                                }
                              } else {
                                ToastShare().getToast("Sai định dạng email");
                              }
                            } else {
                              ToastShare().getToast("Username phải hơn 6 ký tự");
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.TEXT_FOR_PASS,
                                  fontSize: FontSize.TEXT_FORGOT_PASSWORD,
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => SignIn()));
                                },
                                child: Text(
                                  "SIGN IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                                      fontSize: FontSize.TEXT_FORGOT_PASSWORD,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
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
