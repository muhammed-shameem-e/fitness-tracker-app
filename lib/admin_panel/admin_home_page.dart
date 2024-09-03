import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/see_all_categories.dart';
import 'package:fullbody_workout/admin_panel/show_main_categories_exercises/show_abs_exercise.dart';
import 'package:fullbody_workout/admin_panel/show_main_categories_exercises/show_leg_exercise.dart';
import 'package:fullbody_workout/admin_panel/show_main_categories_exercises/show_upperbody_exericse.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/main.dart';
import 'package:fullbody_workout/authentication/form_page.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Edit Categories',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              adminLogOutAlert();
            },
            icon: const Icon(Icons.logout),
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // CategoryItem for UpperBody
                    CategoryItem(
                      title: 'UpperBody',
                      imagePath: 'assets/upperbodyphoto.jpg',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowUpperBodyExerciseAdminSide()));
                      },
                    ),
                    // CategoryItem for Abs
                    CategoryItem(
                      title: 'Abs',
                      imagePath: 'assets/absphoto.jpg',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowAbsExerciseAdminSide()));
                      },
                    ),
                    // CategoryItem for Leg
                    CategoryItem(
                      title: 'Leg',
                      imagePath: 'assets/legphoto.jpg',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowLegExerciseAdminSide()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SeeAllCategories()));
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 20),
                // Welcome message
                Text(
                  'Welcome to Admin Side',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'We are glad to have you here! You can manage all categories, exercises, and more from this panel. Let\'s work together to keep the app up-to-date and ensure the best experience for our users.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Alert dialog for logging out
  void adminLogOutAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout from Admin'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'NO',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            TextButton(
              onPressed: () async {
                final getAdmin = await SharedPreferences.getInstance();
                await getAdmin.setBool(SAVE_ADMIN_VALUE, false);
                final userDb = await Hive.openBox<UsersData>('user_db');
                if (userDb.isEmpty) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const FormPage()));
                } else {
                  final userData = userDb.values.first;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage(data: userData)),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Category item widget
class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
