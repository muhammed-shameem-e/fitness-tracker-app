import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_exercise_one.dart';

class ShowAbsExercise extends StatefulWidget {
  const ShowAbsExercise({
    super.key,
    required this.onComplete,
    required this.completedDay,
  });

  // Callback when the workout is completed
  final VoidCallback onComplete;
  // Day number for tracking progress
  final int completedDay;

  @override
  State<ShowAbsExercise> createState() => _ShowAbsExerciseState();
}

class _ShowAbsExerciseState extends State<ShowAbsExercise> {
  final List<String> abs = [
    'assets/abs1.gif',
    'assets/abs2.gif',
    'assets/abs4.gif',
    'assets/abs5.gif',
    'assets/abs6.gif',
    'assets/abs9.gif',
  ];

   final List<String> names = [
    'Cross arm crunches',
    'Bent leg twist',
    'Dumbbell torture tucks',
    'Dumbbell crunches',
    'Flutter kicks',
    'Reverse crunches',
  ];

  final List<String> benefit = [
    'Targets the upper abs, improves core stability, and enhances abdominal muscle definition.',
    'Engages obliques and lower abs, improves rotational core strength, and increases flexibility.',
    'Combines core strength with added resistance, targeting both upper and lower abs.',
    'Strengthens the upper abs while adding resistance for enhanced muscle growth.',
    'Targets lower abs and hip flexors, improving endurance and core stability.',
    ' Focuses on lower abs, reduces lower back strain, and improves core strength.',
  ];

  List<int> numbers = [11,21,18,15,30,14];
  // @override
  // void initState() {
  //   super.initState();
  //   // Retrieve abs exercises from the Hive database
  //   getAbsExercise();
  // }

  @override
  Widget build(BuildContext context) {
    // Access the current theme
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: theme.iconTheme,
        title: const Text(
          'Abs exercises',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Header row showing the title and current day
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Abs exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
                    ),
                    Text(
                      'Day ${widget.completedDay}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child:ListView.separated(
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              minVerticalPadding: 10,
                              leading: GestureDetector(
                                onTap: (){
                                  showAboutExercise(context, abs[index], names[index], benefit[index]);
                                },
                                child: ClipRRect(
                                          child: Image.asset(abs[index]),
                                        ),
                              ),
                              title: Text('${names[index]}', style: TextStyle(color: textColor)),
                              subtitle: Text('${numbers[index]}', style: TextStyle(color: textColor.withOpacity(0.6))),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(color: textColor.withOpacity(0.2));
                          },
                          itemCount: abs.length,
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Trigger the onComplete callback and navigate to the next screen if exercises are available
                  widget.onComplete();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AbsExerciseOne(
                        index: 0,
                        completedDay: widget.completedDay,
                      ),
                    ));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                ),
                child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show information about the selected exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name,String benefit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.asset(gif),
                ),
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
               Text(
                benefit,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
