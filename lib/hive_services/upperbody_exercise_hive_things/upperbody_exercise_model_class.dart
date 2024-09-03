import 'package:hive_flutter/hive_flutter.dart';
part 'upperbody_exercise_model_class.g.dart';
@HiveType(typeId: 3)
class UpperBodyExercisesModelClass{
  @HiveField(0)
  int? upperBodyId;
  @HiveField(1)
  String upperBodyExerciseName;
  @HiveField(2)
  String upperBodyExerciseGif;
  @HiveField(3)
  String upperBodyReps;
  @HiveField(4)
  String upperBodyExerciseBenefit;
  UpperBodyExercisesModelClass({this.upperBodyId,required this.upperBodyExerciseName,
  required this.upperBodyExerciseGif,required this.upperBodyExerciseBenefit,required this.upperBodyReps});
}