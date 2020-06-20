import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/pay_bloc.dart';
import 'package:my_travel/src/model/history_model.dart';
import 'package:my_travel/src/resources/flight_service.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_buying.dart';
import 'package:my_travel/src/shared/style/color.dart';

class FormBuyingScreen extends StatefulWidget {
  String money;
  History history = History();

  FormBuyingScreen({this.money, this.history});

  @override
  State createState() => new _FormBuyingScreenState();
}

class _FormBuyingScreenState extends State<FormBuyingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar(
          title: "Thông tin người đặt",
          icon: "",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemBuying(
                  hint: "Họ",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemBuying(
                  hint: "Tên",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemBuying(
                  hint: "Quốc tịch",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemBuying(
                  hint: "Số điện thoại",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemBuying(
                  hint: "Email",
                ),
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: InkWell(
                  onTap: () {
                    payBloc.openMoMo(widget.money);
                    FlightService().addHistory(
                      priceFlight: widget.history.priceFlight,
                      titleFlight: widget.history.titleFlight,
                      quantityFlight: widget.history.quantityFlight,
                      nameFlightStartFlight: widget.history.nameFlightStartFlight,
                      nameFlightEndFlight: widget.history.nameFlightEndFlight,
                      iconFlight: widget.history.iconFlight,
                      dateStartFlight: widget.history.dateStartFlight,
                      dateEndFlight: widget.history.dateEndFlight,
                      codeFlight: widget.history.codeFlight,
                      cityStartFlight: widget.history.cityStartFlight,
                      cityEndFlight: widget.history.cityEndFlight,
                      type: LoginService.typeFlight,
                      userID: widget.history.userId,
                    );
                  },
                  child: Container(
                    height: size.width / 7.5,
                    width: size.width / 7.5,
                    decoration: BoxDecoration(
                        color: Palette.COLOR_TITLE_FLIGHTS,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Palette.WHITE,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
