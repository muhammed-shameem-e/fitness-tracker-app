import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/home_page.dart';

class TextFormFieldFormPage extends StatefulWidget {
  const TextFormFieldFormPage({super.key});

  @override
  _TextFormFieldFormPageState createState() => _TextFormFieldFormPageState();
}

class _TextFormFieldFormPageState extends State<TextFormFieldFormPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validate that the first letter of the input is capitalized
  bool _firstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your name',
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 199, 198, 198)),
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Enter your name, at least 4 letters';
                    } else if (!_firstLetterCapital(value)) {
                      return 'First letter should be capital';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your Age',
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 199, 198, 198)),
                    prefixIcon: const Icon(Icons.cake, color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your age';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkInput();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 108, 139, 109)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Check the input and navigate to the HomePage
  Future<void> checkInput() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();

    if (name.isEmpty || age.isEmpty) {
      return;
    }

    final oneUserData = UsersData(
      name: name,
      age: age,
    );

    await addUserDetails(oneUserData);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(data: oneUserData),
      ),
    );
  }
}
