import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Map<String, dynamic>>? categories;
  List<Map<String, dynamic>>? days;
  List<Map<String, dynamic>>? products;

  selectCategory({index}) {
    for (var i = 0; i < categories!.length; i++) {
      if (index == i) {
        categories![i]["selected"] = true;
      } else {
        categories![i]["selected"] = false;
      }
    }
    notifyListeners();
  }

  selectDay({index}) {
    for (var i = 0; i < days!.length; i++) {
      if (index == i) {
        days![i]["selected"] = true;
      } else {
        days![i]["selected"] = false;
      }
    }
    notifyListeners();
  }

  selectProduct({index}) {
    for (var i = 0; i < products!.length; i++) {
      if (index == i) {
        products![i]["selected"] = true;
      } else {
        products![i]["selected"] = false;
      }
    }
    notifyListeners();
  }

  // Future<List<Map<String, dynamic>>> getData() async {
  Future getData() async {
    categories = null;
    days = null;
    products = null;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500), () {
      categories = [
        {"categoryName": "فواكه", "selected": true},
        {"categoryName": "فواكه", "selected": false},
        {"categoryName": "فواكه", "selected": false},
        {"categoryName": "فواكه", "selected": false},
        {"categoryName": "فواكه", "selected": false},
        {"categoryName": "فواكه", "selected": false},
      ];
      notifyListeners();
    });

    await Future.delayed(const Duration(milliseconds: 500), () {
      days = [
        {"day": "السبت", "selected": true},
        {"day": "الاحد", "selected": false},
        {"day": "الاثنين", "selected": false},
        {"day": "الثلاثاء", "selected": false},
        {"day": "الاربعاء", "selected": false},
        {"day": "الخميس", "selected": false},
        {"day": "الجمعة", "selected": false},
      ];
      notifyListeners();
    });
    await Future.delayed(const Duration(milliseconds: 500), () {
      products = [
        {
          "image":
              "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
        {
          "image":
          "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
        {
          "image":
          "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
        {
          "image":
          "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
        {
          "image":
          "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
        {
          "image":
          "https://cdn.al-ain.com/images/2017/5/13/85-010957-red-vegetables-cancer-weight-loss_700x400.jpeg",
          "name": "سلطة كاري مع صوص التوت",
          "calories": "177",
          "carb": "14",
          "protein": "1",
          "fats": "13",
          "price": "320",
          "selected": true
        },
      ];
      notifyListeners();
    });
  }
}
