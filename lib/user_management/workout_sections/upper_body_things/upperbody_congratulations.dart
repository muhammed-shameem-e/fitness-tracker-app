import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_30_days.dart';

class UpperbodyCongratulation extends StatefulWidget {
  // Constructor requiring the completed day as a parameter
  const UpperbodyCongratulation({super.key, required this.completedDay});
  final int completedDay;

  @override
  State<UpperbodyCongratulation> createState() => _UpperBodyCongratulationsState();
}

class _UpperBodyCongratulationsState extends State<UpperbodyCongratulation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 14, 3, 63), ),// Background color of the screen),
      backgroundColor: const Color.fromARGB(255, 14, 3, 63), // Background color of the screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20), // Padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Congratulatory message and completed day text
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
              // GIF image showing congratulations
              ClipRRect(
                child: Image.asset(
                  'assets/congratulations.gif',
                  fit: BoxFit.cover,
                ),
              ),
              // Encouraging message
              const Text(
                "Great job today! Every drop of sweat brings you closer to your goal. Keep pushing, you're stronger than you think!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40,),
              // Continue button to navigate back to the UpperBody30Days screen
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const UpperBody30Days(),
                    ),
                    (Route<dynamic> route) => route.isFirst, // Ensures that the new route is the first route
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // Button border radius
                  )),
                  side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                    width: 6,
                    color: Color.fromARGB(255, 132, 172, 134), // Button border color
                  )),
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
