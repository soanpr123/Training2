import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/splash_screen/splash_screen.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/toast.dart';
import 'package:my_travel/src/ui/navigation/navigation.dart';
import 'package:my_travel/src/ui/sign_in_screen/menu_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  @override
  State createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  String data;
  String data1;

  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SplashScreen(
            backgroundImage: "assets/image/searching.png",
            seconds: 10,
            image: Image.asset("assets/icon/icon_loading.png"),
//                navigateAfterSeconds: loadWidget(),
            loaderColor: Palette.BACKGROUND_COLOR_SPLASH_SCREEN),
        Column(
          children: <Widget>[
            Container(
              height: size.height - 200,
              width: size.width,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SpinKitRipple(
                  size: 100,
                  color: Palette.BACKGROUND_COLOR_SKFC,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  loadWidget() async {
    sharedPreferences = await SharedPreferences.getInstance();
    data = sharedPreferences.getString("user_name");
    data1 = sharedPreferences.getString("password");

    if (data != null || data1 != null) {
      LoginService().login(
          username: data,
          password: data1,
          successBloc: (data) {
            DatumLogin dataLogin = data;
//            Navigator.pop(context);
//            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Navigation(datumLogin: dataLogin),
              ),
            );
            return;
          },
          failBloc: (err) {
            Navigator.pop(context);
            ToastShare().getToast("Error");
            return;
          });
    } else {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
}
