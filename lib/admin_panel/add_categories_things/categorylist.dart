import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/show_category_exercises.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/edit_categories.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';

class CategoriesGridPage extends StatelessWidget {
  final List<CategoriesModelClass> categoriesList;

  const CategoriesGridPage({super.key, required this.categoriesList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: categoriesList.isEmpty
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
                            alertDeleteCategory(context, categories.categoriesId!);
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
            ),
    );
  }

  Future<void> alertDeleteCategory(BuildContext context, int id) async {
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
}
