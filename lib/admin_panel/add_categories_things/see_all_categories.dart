import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/add_categories.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/edit_categories.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/show_category_exercises.dart';
import 'package:fullbody_workout/admin_panel/add_main_categories_exercises/add_leg_exercise.dart';
import 'package:fullbody_workout/admin_panel/new_exercise_things/show_new_exercises.dart';
import 'package:fullbody_workout/admin_panel/show_main_categories_exercises/show_abs_exercise.dart';
import 'package:fullbody_workout/admin_panel/show_main_categories_exercises/show_upperbody_exericse.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';
import 'package:image_picker/image_picker.dart';

class SeeAllCategories extends StatefulWidget {
  const SeeAllCategories({super.key});

  @override
  State<SeeAllCategories> createState() => _SeeAllCategoriesState();
}

class _SeeAllCategoriesState extends State<SeeAllCategories> {
  File? _selectCategoriesPhoto; // Stores selected category photo
  TextEditingController categoriesName = TextEditingController(); // Controller for category name
  late List<int> selectedIds; // List of selected category IDs

  @override
  void initState() {
    super.initState();
    getCategories(); // Fetch categories on initialization
    selectedIds = []; // Initialize selected IDs list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Add Categories'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ShowNewExercises()),
              );
            },
            icon: const Icon(Icons.model_training),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryCard(
                    imagePath: 'assets/upperbodyphoto.jpg',
                    label: 'UpperBody',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ShowUpperBodyExerciseAdminSide()),
                      );
                    },
                  ),
                  CategoryCard(
                    imagePath: 'assets/absphoto.jpg',
                    label: 'Abs',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ShowAbsExerciseAdminSide()),
                      );
                    },
                  ),
                  CategoryCard(
                    imagePath: 'assets/legphoto.jpg',
                    label: 'Leg',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AddLegExercise()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Other Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: categoriesList,
                  builder: (BuildContext context, List<CategoriesModelClass> categoriesList, Widget? child) {
                    return categoriesList.isEmpty
                        ? const Center(child: Text('No Categories available'))
                        : GridView.builder(
                            itemCount: categoriesList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (ctx, index) {
                              final categories = categoriesList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ShowCategoriesExerciseAdminSide(category: categories),
                                          ),
                                        );
                                      },
                                      onLongPress: () {
                                        if (categories.categoriesId != null) {
                                          alertDeleteCategory(categories.categoriesId!);
                                        }
                                      },
                                      child: Container(
                                        height: 125,
                                        width: 125,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color.fromARGB(255, 204, 204, 204),
                                            width: 2,
                                          ),
                                        ),
                                        child: categories.categoriesImage.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.file(File(categories.categoriesImage), fit: BoxFit.cover),
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30, right: 30),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(categories.categoriesName),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => EditCategoryPage(category: categories),
                                                ),
                                              );
                                            },
                                            child: const Text('Edit', style: TextStyle(color: Colors.blue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () => alertAddCategories(), // Show add category dialog
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pick an image from gallery
  Future<void> getCategoriesImage() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _selectCategoriesPhoto = File(returnImage.path);
    });
  }

  // Show confirmation dialog for category deletion
  Future<void> alertDeleteCategory(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                await deleteCategory(id); // Delete the category
                Navigator.of(context).pop();
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to add a new category
  void alertAddCategories() {
    final ValueNotifier<List<int>> selectedIdsNotifier = ValueNotifier<List<int>>([]);

    showDialog(
      context: context,
      builder: (context) {
        return AddCategoryPage(selectedIdsNotifier: selectedIdsNotifier);
      },
    );
  }
}

// Widget for displaying category cards
class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CategoryCard({super.key, 
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 204, 204, 204),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}
