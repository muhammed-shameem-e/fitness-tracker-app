import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/home_page.dart';

class NewCategoryCongratulations extends StatefulWidget {
  const NewCategoryCongratulations({
    super.key,
    required this.completedDay,
  });

  final int completedDay; // The day number that the user has completed

  @override
  State<NewCategoryCongratulations> createState() => _NewCategoryCongratulationsState();
}

class _NewCategoryCongratulationsState extends State<NewCategoryCongratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 14, 3, 63),),
      backgroundColor: const Color.fromARGB(255, 14, 3, 63), // Background color of the page
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20), // Padding for the page content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center align content horizontally
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space out the content vertically
            children: [
              Column(
                children: [
                  // Display congratulations message
                  const Text(
                    'Congratulations...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Display the completed day number
                  Text(
                    'Day ${widget.completedDay} completed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              // Display congratulations GIF
              ClipRRect(
                child: Image.asset(
                  'assets/congratulations.gif',
                  fit: BoxFit.cover,
                ),
              ),
              // Motivational message
              const Text(
                "Great job today! Every drop of sweat brings you closer to your goal. Keep pushing, you're stronger than you think!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Continue button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home page and clear the back stack except for the first route
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        data: UsersData(name: '', age: ''),
                      ),
                    ),
                    (Route<dynamic> route) => route.isFirst,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), // Rounded button corners
                    ),
                  ),
                  side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(
                      width: 6,
                      color: Color.fromARGB(255, 132, 172, 134), // Border color and width
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 70)), // Button size
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
