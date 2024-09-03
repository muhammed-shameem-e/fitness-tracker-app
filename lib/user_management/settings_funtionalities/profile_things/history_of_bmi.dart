import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/profile_things/explain_bmi.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryOfBmi extends StatefulWidget {
  const HistoryOfBmi({super.key});

  @override
  _HistoryOfBmiState createState() => _HistoryOfBmiState();
}

class _HistoryOfBmiState extends State<HistoryOfBmi> {
  Box? box;

  @override
  void initState() {
    super.initState();
    _openBox(); // Open the Hive box when the widget is initialized
  }

  // Opens the Hive box and updates the state
  Future<void> _openBox() async {
    box = await Hive.openBox('saveBmi_db');
    setState(() {}); // Refresh the UI after opening the box
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'), // Title of the app bar
      ),
      body: box == null
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while the box is opening
          : box!.isEmpty
              ? const Center(child: Text('No BMI records found.')) // Show message if no records are found
              : ListView.separated(
                  itemCount: box!.length, // Number of items in the box
                  itemBuilder: (ctx, index) {
                    final record = box!.getAt(index) as Map;
                    final bmi = record['bmi'];
                    final date = DateTime.parse(record['date']).toString(); // Parse date for display
                    return ListTile(
                      title: Text(bmi), // Display BMI value
                      subtitle: Text(date), // Display date
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            box!.deleteAt(index); // Delete the record when the button is pressed
                          });
                        },
                        icon: const Icon(Icons.remove), // Icon for delete button
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => const Divider(), // Divider between list items
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BmiInfoPage(),
            ),
          ); // Navigate to the BMI info page when the button is pressed
        },
        backgroundColor: Colors.blue, // Button color
        child: const Icon(Icons.book, color: Colors.white), // Icon for the button
      ),
    );
  }
}
