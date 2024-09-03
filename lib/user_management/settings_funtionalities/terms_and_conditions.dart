import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              
              // Introduction
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome to our app. By using this application, you agree to these terms and conditions. Please read them carefully.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Categories and Challenges
              Text(
                '2. Categories and Challenges',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'This app features main workout categories: Upper Body, Abs, and Legs. Admins can add more categories that will appear under these main categories. Each category includes a 30-day challenge with 10 exercises per day. Users are encouraged to take one rest day per week. Upon completion of the 30 days, users can restart the challenge while increasing repetitions on their own.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Food and Exercise Information
              Text(
                '3. Food and Exercise Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app provides information about gym-related foods and exercises. There are sections dedicated to cutting diets, bulking diets, and other fitness goals. Users can view the recommended foods with photos, as well as read about the benefits of various exercises in sections like Upper Body, Lower Body, etc.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Advice and Motivation
              Text(
                '4. Advice and Motivation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Our app includes advice and motivational content to help users stay consistent, set realistic goals, and enjoy their fitness journey. Topics like consistency, celebrating progress, and maintaining positivity are covered in these sections.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // User Responsibilities
              Text(
                '5. User Responsibilities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Users can select favorite exercises and track their progress, including calculating their BMI and restarting their progress as needed. It is the user’s responsibility to ensure they follow the appropriate exercises for their fitness level and consult professionals when necessary.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Admin Rights
              Text(
                '6. Admin Rights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Admins have the ability to add exercises and categories. Admin actions should be in line with the app’s objectives and user experience goals.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Disclaimer
              Text(
                '7. Disclaimer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The content provided in this app is for informational purposes only. We do not guarantee specific results and are not responsible for any injuries or issues that may arise from following the exercises or advice provided in this app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Modifications
              Text(
                '8. Modifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We reserve the right to modify these terms and conditions at any time. Users will be notified of significant changes.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Contact Us
              Text(
                '9. Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'If you have any questions regarding these terms and conditions, please contact us through the app’s support page.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
