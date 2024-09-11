import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
import 'package:fullbody_workout/user_management/create_my_plan_sections/day_one_workout_way/user_day_one_exercise.dart';
import 'package:fullbody_workout/user_management/create_my_plan_sections/select_user_exercises.dart';

class CreateMyPlan extends StatefulWidget {
  const CreateMyPlan({super.key});

  @override
  State<CreateMyPlan> createState() => _CreateMyPlanState();
}

class _CreateMyPlanState extends State<CreateMyPlan> {

  @override
  void initState() {
    super.initState();
    // Fetch user exercises when the widget is initialized
    getUserExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(automaticallyImplyLeading: false),
      body: ValueListenableBuilder(
        valueListenable: createUserPlanList,
        builder: (context, List<CreateUserPlan> createUserPlanList, Widget? child) {
          if (createUserPlanList.isEmpty) {
            // Display a message when no user plans are available
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/createplan.jfif', height: 400, width: 300),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Customize your own training plan\nto your preferences.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddIntoUserExercises()));
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
                      'Create my plan',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Display the list of exercises when there are user plans available
            return Stack(
              children: [
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('Exercises', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          final exercises = createUserPlanList[index];
                          return ListTile(
                            minTileHeight: 100,
                            leading: GestureDetector(
                              onTap: () => showAboutExercise(context, exercises.exerciseGif, exercises.exerciseName, exercises.exerciseBenefit),
                              child: exercises.exerciseGif.isNotEmpty
                                  ? ClipRRect(
                                      child: Image.file(File(exercises.exerciseGif), fit: BoxFit.cover, height: 100, width: 50),
                                    )
                                  : null,
                            ),
                            title: Text(exercises.exerciseName),
                            subtitle: Text(exercises.exerciseReps),
                            trailing: IconButton(
                              onPressed: () {
                                if (exercises.id != null) {
                                  alertRestart(exercises.id!);
                                }
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: createUserPlanList.length,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddIntoUserExercises()));
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all<Size>(const Size(150, 50)),
                          ),
                          child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (createUserPlanList.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserExerciseOne(
                                  exercise: createUserPlanList.first,
                                  index: 0,
                                ),
                              ));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all<Size>(const Size(150, 50)),
                          ),
                          child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Show details of an exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name, String benefit) {
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
                  child: Image.file(File(gif)),
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
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show a dialog to confirm the deletion of an exercise
  Future<void> alertRestart(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this exercise?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                deleteExercise(id);
                Navigator.of(context).pop();
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
