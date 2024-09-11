import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/admin_home_page.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/create_my_plan.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/learn_page.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/settings_page.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.data, this.toggletheme,this.index});
  final UsersData data;
  final Function(bool)? toggletheme;
  final int? index;
  
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

    // Show the modal bottom sheet message when the HomePage is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.index == 1){
        showMessageToGoAdminSide();
      }
    });
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

  // Show the modal bottom sheet message
  void showMessageToGoAdminSide() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
             color: Colors.green[400],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "First, you need to add some exercises. To do this, go to the admin side and add your exercises. Once added, you can perform those exercises using the app.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AdminHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 216, 255, 217),
                    foregroundColor: Color.fromARGB(255, 67, 109, 68),
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                   child: Text(
                    'Go to Admin Side',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

