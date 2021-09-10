import 'package:hive/hive.dart';
part 'MentalModel.g.dart';

@HiveType(typeId: 0)
class MentalModel {
  @HiveField(0)
  late int deepBreathing = 0;
  @HiveField(1)
  late int imageryMeditation = 0;
  @HiveField(2)
  late int bodyScan = 0;
  @HiveField(3)
  late int mindfulBreathing = 0;
  @HiveField(4)
  late int muscleRelaxation = 0;
  @HiveField(5)
  late int freeformMeditation = 0;
}
