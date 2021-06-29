import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class FaqWidgetModel {
  String title;
  String content;
  bool enabled;
  FaqWidgetModel({this.content, this.title, this.enabled = false});
}

class FaqViewModel extends ChangeNotifier {
  List<FaqWidgetModel> _faqs = [];
  Future faqFuture;
  List<FaqWidgetModel> get faqs => _faqs;
  FaqViewModel() {
    faqFuture = getFaqText();
  }
  String whatIsText = ' ';
  void justNotify() => notifyListeners();

  getFaqText() async {
    var data = await WebService.getCall(url: GET_FAQ, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      _faqs = data[1]['data']
          .map<FaqWidgetModel>(
            (val) =>
                FaqWidgetModel(content: val['content'], title: val['title']),
          )
          .toList();
    }
  }

  toogleFaqWidget(int index) {
    _faqs[index].enabled = !_faqs[index].enabled;
    notifyListeners();
  }
}
