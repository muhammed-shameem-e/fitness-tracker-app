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
        title: const Text('Select Theme'),
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
                    if (widget.toggleTheme != null) {
                      widget.toggleTheme!(_isDarkMode); // Immediately toggle the theme
                    }
                    _saveThemePreferences(_isDarkMode); // Save preference
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
                    if (widget.toggleTheme != null) {
                      widget.toggleTheme!(_isDarkMode); // Immediately toggle the theme
                    }
                    _saveThemePreferences(_isDarkMode); // Save preference
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
