import 'package:hive_flutter/hive_flutter.dart';
part 'leg_exercise_model_class.g.dart';
@HiveType(typeId: 5)
class LegExerciseModelClass{
  @HiveField(0)
  int? legId;
  @HiveField(1)
  String legExerciseGif;
  @HiveField(2)
  String legExerciseName;
  @HiveField(3)
  String legreps;
  @HiveField(4)
  String legExerciseBenefit;
  LegExerciseModelClass({this.legId,required this.legExerciseGif,required this.legExerciseName,
  required this.legreps,required this.legExerciseBenefit
  });
}