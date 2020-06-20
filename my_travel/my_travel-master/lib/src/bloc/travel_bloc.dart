import 'package:my_travel/src/model/travel_model.dart';
import 'package:my_travel/src/resources/travel_service.dart';
import 'package:rxdart/rxdart.dart';

class TravelBloc {
  TravelService travelService = TravelService();
  final _getTravel = PublishSubject<TravelModel>();

  Observable<TravelModel> get getTravel1 => _getTravel.stream;

  getTravel() async {
    TravelModel itemModel = await travelService.getTravel();
    _getTravel.sink.add(itemModel);
  }
}

final travelBloc = TravelBloc();
