import 'package:hive_flutter/hive_flutter.dart';
part 'abs_exercise_model_class.g.dart';
@HiveType(typeId: 4)
class AbsExerciseModelClass{
  @HiveField(0)
  int? absId;
  @HiveField(1)
  String absExerciseGif;
  @HiveField(2)
  String absExerciseName;
  @HiveField(3)
  String absreps;
  @HiveField(4)
  String absExerciseBenefit;
  AbsExerciseModelClass({this.absId,required this.absExerciseGif,required this.absExerciseName,
  required this.absreps,required this.absExerciseBenefit});
}