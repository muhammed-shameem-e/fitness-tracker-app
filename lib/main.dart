import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/authentication/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Constants
const String SAVE_ADMIN_VALUE = 'adminLoggedIn';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UsersDataAdapter());
  Hive.registerAdapter(AbsExerciseModelClassAdapter());
  Hive.registerAdapter(UpperBodyExercisesModelClassAdapter());
  Hive.registerAdapter(LegExerciseModelClassAdapter());
  Hive.registerAdapter(CategoriesModelClassAdapter());
  Hive.registerAdapter(AddNewExerciseModelClassAdapter());
  Hive.registerAdapter(CreateUserPlanAdapter());

  // Open Hive boxes
  await Hive.openBox<UpperBodyExercisesModelClass>('upperbodyexercise_db');
  await Hive.openBox<UsersData>('user_db');
  await Hive.openBox<LegExerciseModelClass>('legexercise_db');
  await Hive.openBox<AbsExerciseModelClass>('absexercise_db');
  await Hive.openBox<CategoriesModelClass>('categories_db');
  await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  await Hive.openBox<CreateUserPlan>('createuserplan_db');

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreferences();
  }

  // Load theme preferences from SharedPreferences
  Future<void> _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preferences to SharedPreferences
  Future<void> _saveThemePreferences(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Toggle theme and save the preference
  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    _saveThemePreferences(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(toggleTheme: _toggleTheme),
    );
  }
}
