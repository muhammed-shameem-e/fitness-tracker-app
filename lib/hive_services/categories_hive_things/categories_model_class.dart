import 'package:hive_flutter/hive_flutter.dart';
part 'categories_model_class.g.dart';
@HiveType(typeId: 6)
class CategoriesModelClass{
  @HiveField(0)
  int? categoriesId;
  @HiveField(1)
  String categoriesImage;
  @HiveField(2)
  String categoriesName;
  @HiveField(3)
  List<int> exerSizeIds=[];
  CategoriesModelClass({this.categoriesId,required this.categoriesImage,required this.categoriesName,required this.exerSizeIds});
}