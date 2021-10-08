import 'package:stacked/stacked.dart';
import 'package:unic_app/services/web_services.dart';

import '../../../endpoints.dart';

class PrivacyViewModel extends BaseViewModel {
  Future futurePrivacy;
  PrivacyViewModel() {
    futurePrivacy = getTerms();
  }

  String privacy = '';

  getTerms() async {
    var data = await WebService.getCall(url: GET_TERMS, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      print(data);
      privacy = data[1]['data']['privacy']; //TODO: FINISH
    }
  }
}
