import 'package:stacked/stacked.dart';
import 'package:unic_app/services/web_services.dart';

import '../../../endpoints.dart';

class TermsViewModel extends BaseViewModel {
  Future futureTerms;
  TermsViewModel() {
    futureTerms = getTerms();
  }

  String terms = 'terms';

  getTerms() async {
    var data = await WebService.getCall(url: GET_TERMS, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      print(data);
      terms = data[1]['data']; //TODO: FINISH
    }
  }
}
