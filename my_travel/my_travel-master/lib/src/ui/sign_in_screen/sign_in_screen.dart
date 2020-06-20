import 'package:flutter/material.dart';
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_text_input_login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/shared/toast.dart';
import 'package:my_travel/src/ui/navigation/navigation.dart';
import 'package:my_travel/src/ui/sign_in_screen/reset_your_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  SharedPreferences sharedPreferences;

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
                          "SIGN IN",
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
                            controller: _emailController,
                            index: 1,
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
                          titleButTom: "SIGN IN",
                          color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                          size1: FontSize.TITLE_LOGIN,
                          colorTitle: Palette.WHITE,
                          onTap: () async {
//                            SharedPreferences pref = await SharedPreferences.getInstance();

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()));
                            if (_emailController.text.trim().length > 6 ||
                                _emailController.text.trim().contains("@")) {
                              if (_passController.text.trim().length > 6) {
                                LoginService().login(
                                    username: _emailController.text.trim(),
                                    password: _passController.text.trim(),
                                    successBloc: (data) {
                                      DatumLogin dataLogin = data;
                                      setAcc(
                                          dataLogin.name, dataLogin.password);
                                      Navigator.pop(context);
//                                      pref.setString("login", jsonEncode(dataLogin));
//                                      print("datalogin: " + jsonEncode(dataLogin));
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Navigation(
                                                  datumLogin: dataLogin)));
                                      return;
                                    },
                                    failBloc: (err) {
                                      Navigator.pop(context);
                                      ToastShare().getToast(
                                          "Lỗi đăng nhập vui lòng thử lại");
                                      return;
                                    });
                              } else {
                                Navigator.pop(context);
                                ToastShare().getToast("Sai định dạng mật khẩu");
                                return;
                              }
                            } else {
                              Navigator.pop(context);
                              ToastShare().getToast(
                                  "Sai định dạng tên tài khoản hoặc email");
                              return;
                            }
                          },
                        ),
                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                        alignment: Alignment.center,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => ResetsYourPasswordScreen()));
//                          },
//                          child: Text(
//                            "Forgot your password?",
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                color: Palette.TEXT_FOR_PASS,
//                                fontSize: FontSize.TEXT_FORGOT_PASSWORD,
//                                fontWeight: FontWeight.w400),
//                          ),
//                        ),
//                      ),
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

  setAcc(String username, String password) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("check", true);
    sharedPreferences.setString("user_name", username);
    sharedPreferences.setString("password", password);
  }
}
