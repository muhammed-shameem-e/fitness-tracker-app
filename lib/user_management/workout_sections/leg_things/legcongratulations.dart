import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_30_days.dart';

class LegCongratulations extends StatefulWidget {
  const LegCongratulations({super.key, required this.completedDay});
  final int completedDay; // Day number completed in the leg workout challenge

  @override
  State<LegCongratulations> createState() => _LegCongratulationsState();
}

class _LegCongratulationsState extends State<LegCongratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 14, 3, 63),),
      backgroundColor: const Color.fromARGB(255, 14, 3, 63), // Dark background color for the screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20), // Padding for the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center-align content horizontally
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space content evenly vertically
            children: [
              // Congratulations message
              Column(
                children: [
                  const Text(
                    'Congratulations...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              // Congratulations GIF
              ClipRRect(
                child: Image.asset(
                  'assets/congratulations.gif',
                  fit: BoxFit.cover, // Fit the image to cover the container
                ),
              ),
              // Motivational message
              const Text(
                "Great job today! Every drop of sweat brings you closer to your goal. Keep pushing, you're stronger than you think!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center, // Center-align text
              ),
              const SizedBox(height: 20),
              // Continue button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Leg30Days(), // Navigate to the Leg30Days page
                    ),
                    (Route<dynamic> route) => route.isFirst, // Remove all other routes except the first
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), // Round the corners of the button
                    ),
                  ),
                  side: WidgetStateProperty.all<BorderSide>(
                    BorderSide(
                      width: 6,
                      color: const Color.fromARGB(255, 132, 172, 134), // Button border color
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 70)), // Button size
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white, // Text color of the button
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
