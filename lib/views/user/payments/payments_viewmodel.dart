import 'package:stacked/stacked.dart';
import 'package:unic_app/models/user/payment_method.dart';

enum PaymentType { MasterCard, Visa, Cash }

class PaymentsViewModel extends BaseViewModel {
  PaymentType _paymentType = PaymentType.MasterCard;

  List<Map<String, dynamic>> _payments = [
    {
      'card': PaymentMethod(
          cardCcv: '123',
          cardNumber: '12345678',
          expDate: DateTime.now(),
          type: PaymentType.MasterCard),
      'isChoosen': true,
    },
    {
      'card': PaymentMethod(
          cardCcv: '122',
          cardNumber: '1234567890123456',
          expDate: DateTime.now(),
          type: PaymentType.Visa),
      'isChoosen': false,
    },
    {
      'card': PaymentMethod(
          cardCcv: '122',
          cardNumber: '*************',
          expDate: DateTime.now(),
          type: PaymentType.Cash),
      'isChoosen': false,
    }
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
}
