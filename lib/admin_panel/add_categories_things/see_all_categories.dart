import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/add_categories.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/categorylist.dart';
import 'package:fullbody_workout/admin_panel/new_exercise_things/show_new_exercises.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';
import 'package:image_picker/image_picker.dart'; // Import the new page

class SeeAllCategories extends StatefulWidget {
  const SeeAllCategories({super.key});

  @override
  State<SeeAllCategories> createState() => _SeeAllCategoriesState();
}

class _SeeAllCategoriesState extends State<SeeAllCategories> {
  bool _isBottomSheetShown = false; // Tracks if bottom sheet has been shown
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
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: categoriesList,
                  builder: (BuildContext context, List<CategoriesModelClass> categoriesList, Widget? child) {
                    Future.delayed(Duration.zero,(){
                      noticeForNewPage(context);
                    });
                    return CategoriesGridPage(categoriesList: categoriesList); // Use the new page
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
                  'Add Category',
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
  void noticeForNewPage(BuildContext context) {
     if (_isBottomSheetShown) return; // Prevent the sheet from showing again
    _isBottomSheetShown = true; // Mark that the bottom sheet has been shown
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
             color: Colors.green[400],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "To create a new category, you first need to add some exercises. Please go to the 'Add Exercises' page to add exercises and then come back to add a new category.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
