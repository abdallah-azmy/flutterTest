import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<UserData> getUserData() =>
      Hive.box<UserData>('userData');
}