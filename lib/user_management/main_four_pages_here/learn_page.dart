import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/exercise_categories.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/food_categories.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/learn_advice.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/learn_motivation.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key, required this.data});
  final UsersData data;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  // List of image assets for the categories
  final _images = [
    'assets/foodphoto.jpg',
    'assets/exercisephoto.jpg',
    'assets/advicephoto.jpg',
    'assets/motivationphoto.jpg'
  ];

  // List of titles for the categories
  final _titiles = ['Food', 'Exercise', 'Advice', 'Motivation'];

  @override
  void initState() {
    super.initState();
    getUserDetails(); // Fetch user details when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    // Check if the theme is dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header section
          Container(
            height: 200,
            width: double.infinity,
            color: isDarkMode
                ? const Color.fromARGB(255, 41, 39, 39)
                : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learn it',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    'Welcome, ${widget.data.name}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          // GridView for category selection
          Expanded(
            child: GridView.builder(
              itemCount: _images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, index) {
                final screenWidth = MediaQuery.of(context).size.width;
                final imageSize = screenWidth / 2 - 20;
                
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the corresponding category page based on the index
                      if (index == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FoodCategories(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ExerciseCategories(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Advices(),
                          ),
                        );
                      } else if (index == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Motivation(),
                          ),
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        // Display category image
                        SizedBox(
                          height: imageSize,
                          width: imageSize,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              _images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Display category title over the image
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _titiles[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
