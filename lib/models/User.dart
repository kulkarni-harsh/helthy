import 'package:hive/hive.dart';
part 'User.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  late String userName = "";

  @HiveField(1)
  late int age = 0;

  @HiveField(2)
  late int weight = 0;
}
