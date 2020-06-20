import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/shared/item_text_input_login/item_search_flights.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/search_destination_screen.dart';
import 'package:flutter/src/material/dialog.dart' as Dialog;

class RoundTripScreen extends StatefulWidget {
  RoundTripScreen({this.arrivalAirportCode, this.airportName,this.status});

  final String arrivalAirportCode;
  final String airportName;
  final int status;

  @override
  State createState() => new _RoundTripScreenState();
}

class _RoundTripScreenState extends State<RoundTripScreen> {
  static String yearStart;
  static String monthStart;
  static String dayStart;
  static String yearEnd;
  static String monthEnd;
  static String dayEnd;

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
              Container(
                width: size.width,
                height: size.width / 5.5,
                margin: EdgeInsets.fromLTRB(15, size.width / 20, 15, 0),
                padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    color: Palette.COLOR_TAB1),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showPickerDateRange(context);
                  },
                  child: Container(
                    height: size.width / 5.5,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Ngày đi:",
                                style: TextStyle(
                                    color: Palette.COLOR_BORDER_TEXTF,
                                    fontSize: FontSize.TEXT_ITEM_HOTEL,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal),
                              ),
                              StreamBuilder(
                                  stream: flightsBloc.dateStartController,
                                  builder: (context, snapshot) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      child: Text(
                                        snapshot.hasData
                                            ? snapshot.data
                                            : "Chọn ngày đi",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TITLE_ITEM,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            height: size.width / 9,
                            width: 1,
                            color: Palette.COLOR_BORDER_TEXTF,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Ngày về:",
                                  style: TextStyle(
                                      color: Palette.COLOR_BORDER_TEXTF,
                                      fontSize: FontSize.TEXT_ITEM_HOTEL,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  child: StreamBuilder(
                                      stream: flightsBloc.dateEndController,
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.hasData
                                              ? snapshot.data
                                              : "Chọn ngày về",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Palette.BLACK,
                                              fontSize: FontSize.TEXT_DETAIL,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, size.width / 10, 25, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchDestinationScreen(
                          arrivalAirportCode: widget.arrivalAirportCode,
                          yearStart: yearStart,
                          yearEnd: yearEnd,
                          monthStart: monthStart,
                          monthEnd: monthEnd,
                          dayStart: dayStart,
                          dayEnd: dayEnd,
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
    print("canceltext: ${PickerLocalizations.of(context).cancelText}");

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
          flightsBloc.getDateStartController("$dayStart/$monthStart/$yearStart");
//          dayStart = dayStart2;
//          monthStart = monthStart2;
//          yearStart = yearStart2;
        });

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          final data = picker.adapter as DateTimePickerAdapter;
          String date = data.toString();
           yearEnd = date.substring(0, 4);
           monthEnd = date.substring(5, 7);
           dayEnd = date.substring(8, 10);
          flightsBloc
              .getDateEndController("$dayEnd/$monthEnd/$yearEnd");
//          dayEnd = dayEnd2;
//          monthEnd = monthEnd2;
//          yearEnd = yearEnd2;
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
            pe.onConfirm(pe, pe.selecteds);
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
                  Text("Ngày đến:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }
}
