
import 'package:hive/hive.dart';
part 'user_model_class.g.dart';
@HiveType(typeId: 1)
class UsersData {
  @HiveField(0)
   int? id;
  @HiveField(1)
   String name;
  @HiveField(2)
   String age;
  UsersData({this.id,required this.name,required this.age,});
}