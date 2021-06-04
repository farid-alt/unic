import 'package:unic_app/views/user/payments/payments_viewmodel.dart';

class PaymentMethod {
  PaymentType type;
  String cardNumber;
  String cardCcv;
  DateTime expDate;
  PaymentMethod({this.cardCcv, this.cardNumber, this.expDate, this.type});
}
