import 'package:stacked/stacked.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/payment_method.dart';
import 'package:unic_app/services/web_services.dart';

enum PaymentType { MasterCard, Visa, Cash }

class PaymentsViewModel extends BaseViewModel {
  PaymentType _paymentType = PaymentType.MasterCard;
  Future getCreditCards;

  PaymentsViewModel() {
    getCreditCards = getCreditCardsApi();
  }

  void justNotify() => notifyListeners;

  void newCard(card) {
    _payments.add(card);
    print(_payments);
    notifyListeners();
  }

  List<Map<String, dynamic>> _payments = [
    // {
    //   'card': PaymentMethod(
    //       cardCcv: '123',
    //       cardNumber: '12345678',
    //       expDate: DateTime.now(),
    //       type: PaymentType.MasterCard),
    //   'isChoosen': true,
    // },
    // {
    //   'card': PaymentMethod(
    //       cardCcv: '122',
    //       cardNumber: '1234567890123456',
    //       expDate: DateTime.now(),
    //       type: PaymentType.Visa),
    //   'isChoosen': false,
    // },
    // {
    //   'card': PaymentMethod(
    //       cardCcv: '122',
    //       cardNumber: '*************',
    //       expDate: DateTime.now(),
    //       type: PaymentType.Cash),
    //   'isChoosen': false,
    // }
  ];

  get payments => _payments;

  void changeSelectedElement(int index) {
    for (int i = 0; i < _payments.length; i++)
      if (i != index) _payments[i]['isChoosen'] = false;

    _payments[index]['isChoosen'] = true;

    notifyListeners();
  }

  get paymentType => _paymentType;
  set paymentType(PaymentType p) {
    _paymentType = p;
    notifyListeners();
  }

  addCardApi({String cardNumber, String expDate, String ccv}) async {
    print('my id: $ID');
    var data = await WebService.postCall(url: ADD_CREDIT_CARD, data: {
      'id': ID.toString(),
      'card_number': cardNumber,
      'expire_date': expDate,
      'secure_code': ccv
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      //print(data[1]);
      print('success $data[1]');
    }
    return data[0];
  }

  getCreditCardsApi() async {
    var data = await WebService.getCall(
        url: 'http://unik.neostep.az/api/customer/credit-cards?id=$ID',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    if (data[0] == 200) {
      _payments = data[1]['data']
          .map<Map<String, dynamic>>((val) => {
                'card': PaymentMethod(
                    cardCcv: val['secure_code'],
                    cardNumber: val['card_number'],
                    expDate: DateTime.parse(val['expire_date']),
                    type: val['card_number'][0] == 5
                        ? PaymentType.MasterCard
                        : PaymentType.Visa),
                'isChoosen': false,
              })
          .toList();
    }
  }
}
