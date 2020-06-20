import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login2.dart';
import 'package:my_travel/src/shared/item_my_travel/item_or.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/sign_in_screen/sign_in_screen.dart';
import 'package:my_travel/src/ui/sign_in_screen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/image/bg_login.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            color: Palette.BLACK.withOpacity(0.3),
          ),
          Container(
            height: size.height,
            alignment: Alignment.center,
//            margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Palette.WHITE,
                          fontSize: FontSize.TITLE,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 80, 25, 0),
                    child: ItemButTomLogIn(
                        titleButTom: "SIGN IN",
                        color: Palette.WHITE,
                        size1: FontSize.TITLE_LOGIN,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                        },
                        colorTitle: Palette.COLOR_ICON_APBAR),
                  ),
                  Container(margin: EdgeInsets.fromLTRB(0, 15, 0, 15), child: ItemOr()),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: ItemButTomLogIn(
                      titleButTom: "SIGN UP",
                      color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                      size1: FontSize.TITLE_LOGIN,
                      colorTitle: Palette.WHITE,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
//                    child: Text(
//                      "Sign in with",
//                      style:
//                          TextStyle(color: Palette.WHITE, fontSize: FontSize.TEXT_FORGOT_PASSWORD),
//                    ),
//                  ),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        ItemButTomLogIn2(
//                          titleButTom: "FACEBOOK",
//                          icon: "assets/icon/icon_fb.png",
//                          onTap: () async {
//                            bool status = false;
//                            final facebookLogin = FacebookLogin();
//                            final result = await facebookLogin.logIn(['email']);
//
//                            switch (result.status) {
//                              case FacebookLoginStatus.loggedIn:
//                                print(result.accessToken.token);
//                                break;
//                              case FacebookLoginStatus.cancelledByUser:
//                                status = true;
//                                print("cancel login facebook");
//                                break;
//                              case FacebookLoginStatus.error:
//                                print(result.errorMessage);
//                                break;
//                            }
//
//                            if (status) {
//                              return null;
//                            }
//                          },
//                        ),
//                        ItemButTomLogIn2(
//                          titleButTom: "GOOGLE",
//                          icon: "assets/icon/icon_google.png",
//                          onTap: () async {
//                            try {
//                              GoogleSignIn(
//                                scopes: [
//                                  'email',
//                                  'https://www.googleapis.com/auth/contacts.readonly',
//                                ],
//                              ).signIn().then(
//                                    (data) => print(data.email),
//                                  );
//                            } catch (error) {
//                              print(error);
//                            }
//                          },
//                        )
//                      ],
//                    ),
//                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
