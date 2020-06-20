import 'package:my_travel/src/model/hotel_addressmodel.dart';
import 'package:my_travel/src/model/hotels_model.dart';
import 'package:my_travel/src/model/rooms_hotels_models.dart';
import 'package:my_travel/src/resources/hotels_service.dart';
import 'package:rxdart/rxdart.dart';

class HotelsBloc {
  HotelsService backendService = HotelsService();

  final _getAddressHotels = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotel =>
      _getAddressHotels.stream;

  final _getAddressHotelsHanoi = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotelHanoi =>
      _getAddressHotelsHanoi.stream;

  final _getAddressHotelsBangkok = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotelBangkok =>
      _getAddressHotelsBangkok.stream;

  final _getAddressHotelsKorea = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotelKorea =>
      _getAddressHotelsKorea.stream;

  final _getHotels = PublishSubject<HotelsModel>();

  Observable<HotelsModel> get getHotel => _getHotels.stream;

  final _roomsHotelsModels = PublishSubject<RoomsHotelsModels>();

  Observable<RoomsHotelsModels> get getRoomsHotelsModel =>
      _roomsHotelsModels.stream;

  getAddressHotels(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotels.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }

  getAddressHotelsHaNoi(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotelsHanoi.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }

  getAddressHotelsBangkok(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotelsBangkok.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }

  getAddressHotelsKorea(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotelsKorea.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }

  final _getAddressHotelsA = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotelA =>
      _getAddressHotelsA.stream;
  
  
  getAddressHotelsA(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotelsA.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }
  
  final _getAddressHotelsN = PublishSubject<AddressHotelsModel>();

  Observable<AddressHotelsModel> get getAddressHotelN =>
      _getAddressHotelsN.stream;
  
  
  getAddressHotelsN(String namCity) async {
    backendService.getAddressHotels(namCity, (addressHotels) {
      _getAddressHotelsN.sink.add(addressHotels);
      return;
    }, (error) {
      return;
    });
  }

  getHotels(
      String geoId,
      String nameCity,
      String sourceType,
      int yearStart,
      int monthStart,
      int daysStart,
      int yearEnd,
      int monthEnd,
      int daysEnd) async {
    HotelsModel itemModel = await backendService.getHotels(
        geoId,
        nameCity,
        sourceType,
        yearStart,
        monthStart,
        daysStart,
        yearEnd,
        monthEnd,
        daysEnd);
    _getHotels.sink.add(itemModel);
  }

  getRoomsHotels(String idHotels, int yearStart, int monthStart, int daysStart,
      int yearEnd, int monthEnd, int daysEnd) async {
    RoomsHotelsModels itemModel = await backendService.getRoomsHotels(
        idHotels, yearStart, monthStart, daysStart, yearEnd, monthEnd, daysEnd);
    _roomsHotelsModels.sink.add(itemModel);
  }
}

final hotelsBloc = HotelsBloc();
