import 'package:stacked/stacked.dart';
import 'package:unic_app/models/user/user.dart';

class RideIssuesViewModel extends BaseViewModel {
  int _rideId;
  List<String> _issues = [
    'Driver took a poor route',
    'My driver was rude',
    'Ride didn’t happen',
    'Recovering a lost item',
    'I felt unsafe using Unik',
    'Price higher than expected'
  ];

  String _choosenIssue;
  String _choosenIssueDescription;

  get choosenIssueDescription => _choosenIssueDescription;
  set choosenIssueDescription(String val) {
    _choosenIssueDescription = val;
    notifyListeners();
  }

  get rideId => _rideId;
  set rideId(int id) {
    _rideId = id;
    notifyListeners();
  }

  get issues => _issues;

  get choosenIssue => _choosenIssue;
  set choosenIssue(String issue) {
    _choosenIssue = issue;
    notifyListeners();
  }
}
