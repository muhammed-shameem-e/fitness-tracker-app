import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/create_my_plan.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/learn_page.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/settings_page.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.data, this.toggletheme});
  final UsersData data;
  final Function(bool)? toggletheme;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Index of the currently selected page
  int currentIndexValue = 0;
  
  // List of pages for navigation
  late final List<Widget> _appPages;

  @override
  void initState() {
    super.initState();
    _appPages = [
      const WorkoutPage(),
      const CreateMyPlan(),
      LearnPage(data: widget.data),
      SettingsPage(data: widget.data, toggleTheme: widget.toggletheme),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the currently selected page
      body: _appPages[currentIndexValue],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndexValue,
        onTap: (newIndex) {
          setState(() {
            // Update the current page index when a new tab is selected
            currentIndexValue = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
