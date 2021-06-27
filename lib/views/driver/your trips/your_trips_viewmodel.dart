import 'package:stacked/stacked.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/models/user/user.dart';

class YourTripsViewModel extends BaseViewModel {
  bool _online = true;
  Ride _ride = Ride(
    customer: User(id: 123,name: 'Afsana',surname: 'Hajizada',phone: '+994555555555' )
  );
  get isOnline => _online;
  set isOnline(bool status) {
    _online = status;
    notifyListeners();
  }
}
