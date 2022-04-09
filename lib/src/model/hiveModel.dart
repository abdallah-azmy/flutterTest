import 'package:hive/hive.dart';

part 'hiveModel.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String uid;

  @HiveField(3)
  late DateTime date;
}