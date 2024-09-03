import 'package:hive_flutter/hive_flutter.dart';
 part 'model_class.g.dart';
@HiveType(typeId: 7)
class AddNewExerciseModelClass{
  @HiveField(0)
  int addAllExerciseId;
  @HiveField(1)
  String execiseName;
  @HiveField(2)
  String execiseGif;
  @HiveField(3)
  String exerciseReps;
  @HiveField(4)
  String exerciseBenefit;
  AddNewExerciseModelClass({required this.addAllExerciseId,required this.execiseName,required this.execiseGif,required this.exerciseBenefit,required this.exerciseReps});
}