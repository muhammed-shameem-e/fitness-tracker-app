import 'package:hive_flutter/hive_flutter.dart';


Future <void> asyncFuntion() async{
  final newBox = await Hive.openBox('newbox_db');
  
}