import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upper_body_exercise_one.dart';

class ShowUpperBodyExercise extends StatefulWidget {
  final VoidCallback onComplete;
  final int completedDay;
  
  // Constructor to initialize with required parameters
  const ShowUpperBodyExercise({
    super.key, 
    required this.onComplete, 
    required this.completedDay,
  });

  @override
  State<ShowUpperBodyExercise> createState() => _ShowUpperBodyExerciseState();
}

class _ShowUpperBodyExerciseState extends State<ShowUpperBodyExercise> {

  final List<String> upperbody = [
    'assets/pushup1.gif',
    'assets/pushup2.gif',
    'assets/pushup3.gif',
    'assets/pushup4.gif',
    'assets/pushup5.gif',
    'assets/pushup6.gif',
    'assets/pushup7.gif',
  ];

  final List<String> names = [
    'Standard Grip',
    'Feet Elevated',
    'Spider Man',
    'Eccentric',
    'Wide Grip',
    'Atomic',
    'Pike',
  ];

  final List<String> benefit = [
      'Strengthens chest, shoulders, and triceps; improves core stability and shoulder mobility.',
      'Increases upper chest and shoulder activation; boosts core engagement and upper body strength.',
      'Targets obliques, improves mobility and coordination, and builds upper body strength.',
      'Builds strength through controlled lowering, improves form, and increases endurance.',
      'Focuses on outer chest and shoulders, reduces tricep involvement, and improves stability.',
      'Combines push-up with knee tuck, enhancing core stability and total body strength.',
      'Strengthens shoulders and upper chest, improves core engagement, and builds flexibility.'
    ];

  List<int> numbers = [25, 12, 29, 18, 23, 15, 27];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                // Header Row displaying title and day
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UpperBody exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Day ${widget.completedDay}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                 child: ListView.separated(
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              minVerticalPadding: 15, 
                              leading:
                                    GestureDetector(
                                      onTap: (){
                                        showAboutExercise(context, upperbody[index], names[index], benefit[index]);
                                      },
                                      child: ClipRRect(
                                          child: Image.asset(upperbody[index]),
                                        ),
                                    ),
                              title: Text('${names[index]}'),
                              subtitle: Text('x${numbers[index]}'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: upperbody.length,
                        ),
                ),
              ],
            ),
          ),
          // Start button at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                    widget.onComplete(); 
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpperBodyExerciseOne(
                          index: 0,
                          completedDay: widget.completedDay,
                          listLength: upperbody.length,
                        ),
                      ),
                    );
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
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show a bottom sheet with exercise details
  void showAboutExercise(BuildContext context, String gif, String name,String benefit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                  Navigator.of(context).pop();
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
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
