import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/leg_exerice_one.dart';

class ShowLegExercise extends StatefulWidget {
  const ShowLegExercise({super.key, required this.onComplete, required this.completedDay});
  final VoidCallback onComplete; // Callback function to notify when exercise is completed
  final int completedDay; // Indicates which day of the exercise is being shown

  @override
  State<ShowLegExercise> createState() => _ShowLegExerciseState();
}

class _ShowLegExerciseState extends State<ShowLegExercise> {

  final List<String> leg = [
    'assets/leg1.gif',
    'assets/leg2.gif',
    'assets/leg3.gif',
    'assets/leg4.gif',
    'assets/leg6.gif',
    'assets/leg7.gif',
    'assets/leg8.gif',
    'assets/leg9.gif',
  ];

  final List<String> names = [
    'Plank with both leg',
    'Mountain climber',
    'walking lungers',
    'Jump squat',
    'Glute bridge right leg',
    'Glute bridge left leg',
    'Lungers with both leg',
    'Body weight squat'
  ];

  final List<int> numbers = [23, 11, 29, 15, 27, 19, 12, 30];

  final List<String> benefit = [
    'Strengthens the core, shoulders, and back; improves stability and endurance.',
    'Enhances cardiovascular endurance, core stability, and overall strength while improving agility.',
    'Builds lower body strength, improves balance, and enhances flexibility and coordination.',
    'Increases lower body power, boosts cardiovascular fitness, and enhances explosive strength.',
    'Targets the glutes, hamstrings, and lower back; improves hip stability and strength in the right leg.',
    'Similar to the right leg, but targets the left leg, enhancing glute and hamstring strength, and hip stability.',
    'Strengthens quads, hamstrings, and glutes; improves balance and coordination while enhancing overall lower body strength.',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set the background color based on the theme
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set the app bar background color based on the theme
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                // Header row showing the title and the day of the exercise
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Leg exercises', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Day ${widget.completedDay}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 20), // Space between the header and the list
                // List of exercises
                Expanded(
                  child:ListView.separated(
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              minVerticalPadding: 15, // Adjust the padding
                              leading: GestureDetector(
                                onTap: (){
                                  showAboutExercise(context, leg[index], names[index], benefit[index]);
                                },
                                child: ClipRRect(
                                          child: Image.asset(leg[index]), // Display the exercise image
                                        ),
                              ),
                              title: Text('${names[index]}'), // Display the exercise name
                              subtitle: Text('${numbers[index]}'), // Display the exercise repetitions
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(), // Add a divider between the list items
                          itemCount: leg.length, // Set the number of exercises in the list
                        ),
                ),
              ],
            ),
          ),
          // Start button at the bottom of the screen
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  widget.onComplete(); // Notify that the exercise is completed
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LegExerciseOne(
                          index: 0, // Index of the exercise in the list
                          completedDay: widget.completedDay, // Pass the completed day
                        ),
                      ),
                    );
                  },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Set button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Round the corners of the button
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)), // Set the button size
                ),
                child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), // Set the button text
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show details about the selected exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name,String benefit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the exercise gif
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.asset(gif),
                ),
              ),
              // Display the exercise name
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Display a motivational quote
              Text(
                benefit,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Close button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet when pressed
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Set button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Round the corners of the button
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)), // Set the button size
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), // Set the button text
              ),
            ],
          ),
        );
      },
    );
  }
}
