import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';

class EditCategoryPage extends StatefulWidget {
  final CategoriesModelClass category;

  const EditCategoryPage({super.key, required this.category});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  File? _selectCategoriesPhoto; // Stores selected category photo
  final TextEditingController _editCategoriesNameController = TextEditingController(); // Controller for category name
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    // Initialize the controller and photo with category data
    _editCategoriesNameController.text = widget.category.categoriesName;
    _selectCategoriesPhoto = File(widget.category.categoriesImage);
  }

  // Check if the first letter of the value is capital
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  // Pick an image from gallery
  Future<void> _getCategoryImage() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _selectCategoriesPhoto = File(returnImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _getCategoryImage, // Open image picker on tap
                  child: _selectCategoriesPhoto != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _selectCategoriesPhoto!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
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
                  controller: _editCategoriesNameController,
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectCategoriesPhoto != null && _editCategoriesNameController.text.isNotEmpty) {
                        // Create an updated category object
                        final updatedCategory = CategoriesModelClass(
                          categoriesId: widget.category.categoriesId,
                          categoriesImage: _selectCategoriesPhoto!.path,
                          categoriesName: _editCategoriesNameController.text,
                          exerSizeIds: widget.category.exerSizeIds,
                        );
                        await updateCategories(updatedCategory); // Update category in database
                        Navigator.of(context).pop(); // Return to previous screen
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
