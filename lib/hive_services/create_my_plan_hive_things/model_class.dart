import 'package:hive/hive.dart';

part 'model_class.g.dart';

@HiveType(typeId: 10)  
class CreateUserPlan{
  @HiveField(0)
  int? id;  

  @HiveField(1)
  String exerciseName;

  @HiveField(2)
  String exerciseGif;

  @HiveField(3)
  String exerciseReps;

  @HiveField(4)
  String exerciseBenefit;

  CreateUserPlan({this.id,required this.exerciseName,required this.exerciseGif,
  required this.exerciseBenefit,required this.exerciseReps});
}
