import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_30_days.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, this.newProgress});
  final double? newProgress;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  double absProgress = 0.0;
  double legProgress = 0.0;
  double upperBodyProgress = 0.0; 
  double newProgress = 0.0;

  @override
  void initState() {
    super.initState();
    getCategories(); // Load categories (assuming this function exists)
    _loadAbsProgress();
    _loadLegProgress();
    _loadUpperBodyProgress(); 
    _loadNewProgress();
  }

  // Load progress for the new category
  Future<void> _loadNewProgress() async {
    final box = await Hive.openBox('newWorkoutBox');
    final lastCompleteDay = box.get('lastCompletednewDay', defaultValue: 0);
    setState(() {
      newProgress = lastCompleteDay / 30;
    });
  }

  // Load progress for abs workout
  Future<void> _loadAbsProgress() async {
    final box = await Hive.openBox('absWorkoutBox');
    final lastCompletedDay = box.get('lastCompletedAbsDay', defaultValue: 0);
    setState(() {
      absProgress = lastCompletedDay / 30;
    });
  }

  // Load progress for leg workout
  Future<void> _loadLegProgress() async {
    final box = await Hive.openBox('legWorkoutBox');
    final lastCompletedDay = box.get('lastCompletedLegDay', defaultValue: 0);
    setState(() {
      legProgress = lastCompletedDay / 30;
    });
  }

  // Load progress for upper body workout
  Future<void> _loadUpperBodyProgress() async {
    final box = await Hive.openBox('upperBodyWorkoutBox');
    final lastCompletedDay = box.get('lastCompletedUpperBodyDay', defaultValue: 0);
    setState(() {
      upperBodyProgress = lastCompletedDay / 30;
    });
  }

  // Open the new workout box
  Future<Box> _openNewWorkoutBox() async {
    return await Hive.openBox('newWorkoutBox');
  }

  @override
  Widget build(BuildContext context) {
    final photos = [
      'assets/upperbodyphoto.jpg',
      'assets/absphoto.jpg',
      'assets/legphoto.jpg'
    ];
    final sections = ['UpperBody', 'Abs', 'Leg'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workout Creator',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Workout sections (UpperBody, Abs, Leg)
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (index == 0) {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const UpperBody30Days()));
                          if (result != null && result is int) {
                            setState(() {
                              upperBodyProgress = result / 30;
                            });
                          }
                        } else if (index == 1) {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Abs30Days()));
                          if (result != null && result is int) {
                            setState(() {
                              absProgress = result / 30;
                            });
                          }
                        } else if (index == 2) {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Leg30Days()));
                          if (result != null && result is int) {
                            setState(() {
                              legProgress = result / 30;
                            });
                          }
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                photos[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              sections[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          // Progress indicators for each section
                          if (index == 0) 
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${30 - (upperBodyProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      Text('${(upperBodyProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: upperBodyProgress,
                                    backgroundColor: Colors.white,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          if (index == 1) 
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${30 - (absProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      Text('${(absProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: absProgress,
                                    backgroundColor: Colors.white,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          if (index == 2) 
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${30 - (legProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      Text('${(legProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: legProgress,
                                    backgroundColor: Colors.white,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Text('Other Categories',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
              const SizedBox(height: 10),
              // FutureBuilder to load new workout categories
              FutureBuilder<Box>(
                future: _openNewWorkoutBox(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error loading Hive box');
                  }
                  final box = snapshot.data!;
                  return ValueListenableBuilder(
                    valueListenable: categoriesList, // Assuming categoriesList is defined elsewhere
                    builder: (BuildContext context,
                        List<CategoriesModelClass> categoriesList, Widget? child) {
                      return Column(
                        children: List.generate(categoriesList.length, (index) {
                          final categories = categoriesList[index];
                          final lastCompletedDay = box.get('${categories.categoriesName}lastCompletednewDay', defaultValue: 0);
                          final currentProgress = lastCompletedDay / 30;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewCategory30Days(
                                      category: categories,
                                    ),
                                  ),
                                );
                                if (result != null && result is int) {
                                  setState(() {
                                    newProgress = result / 30;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: categories.categoriesImage.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              File(categories.categoriesImage),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, top: 20),
                                    child: Text(
                                      categories.categoriesName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${30 - (currentProgress * 30).toInt()} days left',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${(currentProgress * 100).toStringAsFixed(0)}% completed',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        LinearProgressIndicator(
                                          value: currentProgress,
                                          backgroundColor: Colors.white,
                                          valueColor: const AlwaysStoppedAnimation<Color>(
                                              Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
