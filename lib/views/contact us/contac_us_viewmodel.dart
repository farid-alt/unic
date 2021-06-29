import 'package:stacked/stacked.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class ContactUsViewModel extends BaseViewModel {
  String fbUrl;
  String instaUrl;
  String emailUrl;

  Future getContactUs;

  ContactUsViewModel() {
    getContactUs = getContactUsApi();
  }

  getContactUsApi() async {
    var data = await WebService.getCall(url: CONTACT_US, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      fbUrl = data[1]['data']['fb'];
      instaUrl = data[1]['data']['ins'];
      emailUrl = data[1]['data']['email'];
    }
  }
}
