import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/select_categories_exercises.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryPage extends StatefulWidget {
  final ValueNotifier<List<int>> selectedIdsNotifier;

  const AddCategoryPage({super.key, required this.selectedIdsNotifier});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  File? _selectedCategoryPhoto; // Stores the selected category photo
  final TextEditingController _categoriesNameController = TextEditingController(); // Controller for category name
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  // Check if the first letter of the value is capital
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  // Pick an image from the gallery
  Future<void> _getCategoryImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedCategoryPhoto = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _getCategoryImage, // Open image picker on tap
                child: _selectedCategoryPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedCategoryPhoto!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: IconButton(
                            onPressed: _getCategoryImage, // Open image picker on button press
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _categoriesNameController,
                decoration: InputDecoration(
                  hintText: 'Category Name',
                  prefixIcon: const Icon(Icons.fitness_center),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  if (!isFirstLetterCapital(value)) {
                    return 'Category name should start with a capital letter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  // Open the AddIntoCategory page and retrieve selected exercise IDs
                  final List<int>? ids = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddIntoCategory(),
                    ),
                  );
                  if (ids != null) {
                    widget.selectedIdsNotifier.value = ids; // Update selected IDs
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      'Add Exercises',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedCategoryPhoto != null && _categoriesNameController.text.isNotEmpty) {
                      // Create a new category object with details
                      final categoriesDetail = CategoriesModelClass(
                        categoriesId: DateTime.now().millisecond,
                        categoriesImage: _selectedCategoryPhoto!.path,
                        categoriesName: _categoriesNameController.text,
                        exerSizeIds: widget.selectedIdsNotifier.value,
                      );
                      await addCategories(categoriesDetail); // Add the category
                      _categoriesNameController.clear(); // Clear the input fields
                      setState(() {
                        _selectedCategoryPhoto = null; // Reset photo selection
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
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
