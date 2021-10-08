import 'package:unic_app/views/user/payments/payments_viewmodel.dart';

class PaymentMethod {
  PaymentType type;
  String cardNumber;
  String cardCcv;
  String expDate;
  String id;
  PaymentMethod(
      {this.cardCcv, this.cardNumber, this.expDate, this.type, this.id});
}
