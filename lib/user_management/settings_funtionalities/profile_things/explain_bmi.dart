import 'package:flutter/material.dart';

class BmiInfoPage extends StatelessWidget {
  const BmiInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Information'), // Title of the app bar
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal, // App bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Padding around the body content
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Card(
                color: isDarkMode ? Colors.teal.shade700 : Colors.teal.shade100, // Card color based on theme
                child: Padding(
                  padding: const EdgeInsets.all(15.0), // Padding inside the card
                  child: Text(
                    'What is BMI?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.teal.shade100 : Colors.teal.shade900, // Text color based on theme
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between cards
              // BMI Explanation Section
              Card(
                color: isDarkMode ? Colors.cyan.shade900 : Colors.cyan.shade50, // Card color based on theme
                child: const Padding(
                  padding: EdgeInsets.all(15.0), // Padding inside the card
                  child: Text(
                    'BMI stands for Body Mass Index. It is a number calculated from your weight and height. '
                    'BMI is a useful tool to determine whether an individual is underweight, normal weight, '
                    'overweight, or obese. It helps in assessing the overall health status.',
                    style: TextStyle(fontSize: 18), // Text style for BMI explanation
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between cards
              // Underweight Section
              Card(
                color: isDarkMode ? Colors.orange.shade900 : Colors.orange.shade100, // Card color based on theme
                child: Padding(
                  padding: const EdgeInsets.all(15.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Underweight',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.orange.shade100 : Colors.orange.shade900, // Text color based on theme
                        ),
                      ),
                      const SizedBox(height: 10), // Space between title and text
                      const Text(
                        'A BMI less than 18.5 is considered underweight. It may indicate malnutrition, '
                        'eating disorders, or other health problems.',
                        style: TextStyle(fontSize: 16), // Text style for underweight explanation
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between cards
              // Normal Weight Section
              Card(
                color: isDarkMode ? Colors.green.shade900 : Colors.green.shade100, // Card color based on theme
                child: Padding(
                  padding: const EdgeInsets.all(15.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Normal Weight',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.green.shade100 : Colors.green.shade900, // Text color based on theme
                        ),
                      ),
                      const SizedBox(height: 10), // Space between title and text
                      const Text(
                        'A BMI between 18.5 and 24.9 is considered normal weight. This range is associated with '
                        'the lowest risk of weight-related health problems.',
                        style: TextStyle(fontSize: 16), // Text style for normal weight explanation
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between cards
              // Overweight Section
              Card(
                color: isDarkMode ? Colors.yellow.shade900 : Colors.yellow.shade100, // Card color based on theme
                child: Padding(
                  padding: const EdgeInsets.all(15.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overweight',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.yellow.shade100 : Colors.yellow.shade900, // Text color based on theme
                        ),
                      ),
                      const SizedBox(height: 10), // Space between title and text
                      const Text(
                        'A BMI between 25 and 29.9 is considered overweight. Being overweight increases the risk of '
                        'developing health problems like heart disease, diabetes, and more.',
                        style: TextStyle(fontSize: 16), // Text style for overweight explanation
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between cards
              // Obesity Section
              Card(
                color: isDarkMode ? Colors.red.shade900 : Colors.red.shade100, // Card color based on theme
                child: Padding(
                  padding: const EdgeInsets.all(15.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Obesity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.red.shade100 : Colors.red.shade900, // Text color based on theme
                        ),
                      ),
                      const SizedBox(height: 10), // Space between title and text
                      const Text(
                        'A BMI of 30 or higher is considered obese. Obesity is a serious condition that '
                        'increases the risk of many health issues, including heart disease, diabetes, and more.',
                        style: TextStyle(fontSize: 16), // Text style for obesity explanation
                      ),
                    ],
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
