import 'package:flutter/material.dart';
import 'package:fullbody_workout/authentication/text_form_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormpageState();
}

class _FormpageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gymwhallpaper.jfif'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5), 
          ),
          // Content area with safe padding
          const SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 75),
                child: Column(
                  children: [
                    // Title and description
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white, 
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), 
                            Text(
                              "Welcome, buddy\nJoin us for personalized workouts,\nexpert guidance, and a supportive community.\nStart your fitness journey today.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Form for user input
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: TextFormFieldFormPage(),
                    ), 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
