import 'dart:convert';

import 'package:newsapp/model/listartical.dart';
import 'package:newsapp/model/searchmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksSave {
  addbookmark(Articles articl) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    String list = prefs.getString('artcal');
    print('================');
    print(list);
    print('================');
    if (prefs.containsKey('artcal')) {
      ListArticals artlist = ListArticals.fromJson(json.decode(list));
      if (artlist.list.isEmpty) {
        ListArticals mm = ListArticals();
        mm.list.add(jsonEncode(articl.toJson()));
        prefs.setString('artcal', jsonEncode(mm.toJson()));
      }
    } else {
      ListArticals data = ListArticals.fromJson(jsonDecode(list));
      data.list.add(jsonEncode(articl.toJson()));
      prefs.setString('artcal', jsonEncode(data.toJson()));
    }
  }

  Future<void> addToSP(Articles tList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('graphLists') ?? '[]');
    List<Articles> data = [];
    jsonData.forEach((element) {
      data.add(Articles.fromJson(element));
    });
    print(data.length);
    data.forEach((element) {
      print(element);
    });
    data.add(tList);
    prefs.setString('graphLists', jsonEncode(data));
  }

  Future<List<Articles>> getSP() async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('graphLists') ?? '[]');
    List<Articles> data = [];
    jsonData.forEach((element) {
      data.add(Articles.fromJson(element));
    });
    return data;
  }

  // check() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs.getString('artcal'));
  //   ListArticals data =
  //       ListArticals.fromJson(jsonDecode(prefs.getString('artcal')));
  //   print(data.list[0].title);
  // }

  removebookmark() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
