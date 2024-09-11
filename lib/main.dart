import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
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
  Hive.registerAdapter(CategoriesModelClassAdapter());
  Hive.registerAdapter(AddNewExerciseModelClassAdapter());
  Hive.registerAdapter(CreateUserPlanAdapter());

  // Open Hive boxes
  await Hive.openBox<UsersData>('user_db');
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
  final ValueNotifier<bool> _themeNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadThemePreferences();
  }

  Future<void> _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeNotifier.value = isDarkMode;
  }

  Future<void> _saveThemePreferences(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void _toggleTheme(bool isDarkMode) {
    _themeNotifier.value = isDarkMode;
    _saveThemePreferences(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _themeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: SplashScreen(toggleTheme: _toggleTheme),
        );
      },
    );
  }
}
