import 'package:newsapp/model/searchmodel.dart';

class ListArticals {
  List<String> list = [];

  ListArticals({this.list});

  ListArticals.fromJson(Map<String, dynamic> json) {
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    return data;
  }
}
