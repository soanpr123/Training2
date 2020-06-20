import 'dart:async';

import 'package:my_travel/src/model/code_airport_model.dart';
import 'package:my_travel/src/model/flight_model.dart';
import 'package:my_travel/src/model/flight_one_way_model.dart';
import 'package:my_travel/src/resources/flight_service.dart';
import 'package:rxdart/rxdart.dart';

class FlightsBloc {
  bool visible = true;

  FlightService backendService = FlightService();

  final _getCodeAirportModel = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport =>
      _getCodeAirportModel.stream;
  final _getCodeAirportModel2 = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport2 =>
      _getCodeAirportModel2.stream;

  final _getCodeAirportModel3 = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport3 =>
      _getCodeAirportModel3.stream;

  final _getCodeAirportModel1 = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport1 =>
      _getCodeAirportModel1.stream;

  final _getCodeAirportModel5 = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport5 =>
      _getCodeAirportModel5.stream;

  final _getCodeAirportModel6 = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirport6 =>
      _getCodeAirportModel6.stream;

  getCodeAirportModel(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel.sink.add(itemModel);
  }

  getCodeAirportModel1(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel1.sink.add(itemModel);
  }

  getCodeAirportModel2(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel2.sink.add(itemModel);
  }

  getCodeAirportModel3(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel3.sink.add(itemModel);
  }

  getCodeAirportModel5(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel5.sink.add(itemModel);
  }

  getCodeAirportModel6(String searchCity) async {
    CodeAirportModel itemModel =
        await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportModel6.sink.add(itemModel);
  }

  final _getFlight = PublishSubject<DataFlight>();

  Observable<DataFlight> get getFlight => _getFlight.stream;

  final _getFlight1 = PublishSubject<DataFlight2>();

  Observable<DataFlight2> get getFlight1 => _getFlight1.stream;

  getFlights(
      String startCode,
      String endCode,
      String numAdults,
      String yearStart,
      String monthStart,
      String dayStart,
      String yearEnd,
      String monthEnd,
      String dayEnd) async {
    DataFlight itemModel = await backendService.getFlight(startCode, endCode,
        numAdults, yearStart, monthStart, dayStart, yearEnd, monthEnd, dayEnd);
    _getFlight.sink.add(itemModel);
  }

  getFlights1(String startCode, String endCode, String yearStart,
      String monthStart, String dayStart) async {
    DataFlight2 itemModel = await backendService.getFlight1(
        startCode, endCode, yearStart, monthStart, dayStart);
    _getFlight1.sink.add(itemModel);
  }

  StreamController _dateStartController = StreamController.broadcast();
  StreamController _dateEndController = StreamController.broadcast();

  Stream get dateStartController => _dateStartController.stream;

  Stream get dateEndController => _dateEndController.stream;

  getDateStartController(String value) => _dateStartController.sink.add(value);

  getDateEndController(String value) => _dateEndController.sink.add(value);

  StreamController _dateStart2Controller = StreamController.broadcast();

  Stream get dateStart2Controller => _dateStart2Controller.stream;

  getDateStart2Controller(String value) =>
      _dateStart2Controller.sink.add(value);



  final _getCodeAirportA = PublishSubject<CodeAirportModel>();

  Observable<CodeAirportModel> get getCodeAirportA =>
      _getCodeAirportA.stream;

  getAirportA(String searchCity) async {
    CodeAirportModel itemModel =
    await backendService.getCodeAirportModel(searchCity);
    _getCodeAirportA.sink.add(itemModel);
  }
  
  
}

final flightsBloc = FlightsBloc();
