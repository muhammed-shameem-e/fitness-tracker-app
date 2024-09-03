import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key, required this.toggleTheme});
  
  final Function(bool)? toggleTheme;

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool _isDarkMode = false;

  // Load the theme preference from SharedPreferences
  Future<void> _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save the theme preference to SharedPreferences
  Future<void> _saveThemePreferences(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  void initState() {
    super.initState();
    _loadThemePreferences(); // Load theme preference when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (widget.toggleTheme != null) {
                widget.toggleTheme!(_isDarkMode);
              }
              await _saveThemePreferences(_isDarkMode);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Dark'),
              trailing: Radio<bool>(
                value: true,
                groupValue: _isDarkMode,
                onChanged: (bool? value) {
                  setState(() {
                    _isDarkMode = value!;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('White'),
              trailing: Radio<bool>(
                value: false,
                groupValue: _isDarkMode,
                onChanged: (bool? value) {
                  setState(() {
                    _isDarkMode = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
