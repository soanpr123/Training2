import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_search_flights.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/search_destination_screen.dart';
import 'package:flutter/src/material/dialog.dart' as Dialog;

class FlyOneWayScreen extends StatefulWidget {
  FlyOneWayScreen({this.arrivalAirportCode, this.airportName,this.status});

  final String arrivalAirportCode;
  final String airportName;
  final int status;

  @override
  State createState() => new _FlyOneWayScreenState();
}

class _FlyOneWayScreenState extends State<FlyOneWayScreen> {
  static String yearStart;
  static String monthStart;
  static String dayStart;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
      body: Container(
        margin: EdgeInsets.fromLTRB(15, size.width / 10, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15, size.width / 10, 15, 0),
                child: ItemSearchFlights(
                  title: "Từ:",
                  hintText: widget.airportName,
                ),
              ),
              InkWell(
                onTap: () {
                  showPickerDateRange(context);
                },
                child: Container(
                  width: size.width,
                  height: size.width / 5.5,
                  margin: EdgeInsets.fromLTRB(15, size.width / 20, 15, 0),
                  padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      color: Palette.COLOR_TAB1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ngày đi:",
                          style: TextStyle(
                              color: Palette.COLOR_BORDER_TEXTF,
                              fontSize: FontSize.TEXT_ITEM_HOTEL,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                              stream: flightsBloc.dateStart2Controller,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData
                                      ? snapshot.data
                                      : "Chọn ngày đi",
                                  style: TextStyle(
                                      color: Palette.BLACK,
                                      fontSize: FontSize.TEXT_DETAIL,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal),
                                );
                              })),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, size.width / 10, 25, 0),
                child: InkWell(
                  onTap: () {
                    print(widget.status);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchDestinationScreen(
                          arrivalAirportCode: widget.arrivalAirportCode,
                          yearStart: yearStart,
                          monthStart: monthStart,
                          dayStart: dayStart,
                          status: widget.status,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    height: size.width / 6.5,
                    decoration: BoxDecoration(
                      color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Tiếp tục để tìm điểm đến",
                      style: TextStyle(
                          fontSize: FontSize.TITLE_ITEM,
                          fontWeight: FontWeight.w600,
                          color: Palette.WHITE),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPickerDateRange(BuildContext context) {
    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          final data = picker.adapter as DateTimePickerAdapter;
          String date = data.toString();
          yearStart = date.substring(0, 4);
          monthStart = date.substring(5, 7);
          dayStart = date.substring(8, 10);
          flightsBloc
              .getDateStart2Controller("$dayStart/$monthStart/$yearStart");
        });
    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(PickerLocalizations.of(context).cancelText)),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
          },
          child: new Text(PickerLocalizations.of(context).confirmText))
    ];

    Dialog.showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Chọn ngày"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Ngày đi:"),
                  ps.makePicker(),
                ],
              ),
            ),
          );
        });
  }
}
