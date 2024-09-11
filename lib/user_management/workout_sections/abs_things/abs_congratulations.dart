import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_30_days.dart';

class AbsCongratulations extends StatefulWidget {
  const AbsCongratulations({super.key, required this.completedDay});
  
  final int completedDay;

  @override
  State<AbsCongratulations> createState() => _AbsCongratulationsState();
}

class _AbsCongratulationsState extends State<AbsCongratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 14, 3, 63),),
      backgroundColor: const Color.fromARGB(255, 14, 3, 63),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Congratulations message and completed day text
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Abs30Days(),
                    ),
                    (Route<dynamic> route) => route.isFirst,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(
                      width: 6,
                      color: Color.fromARGB(255, 132, 172, 134),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 70)),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
