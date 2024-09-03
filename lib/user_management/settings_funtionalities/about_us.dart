import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome header
              Text(
                'Welcome to Our Fitness App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Description of the app
              Text(
                'Our app is designed to help you take control of your fitness journey. '
                'With three main categories - Upper Body, Abs, and Legs - you can embark on a 30-day challenge, where each day includes 10 exercises. '
                'One day a week is reserved for rest. After completing the 30-day challenge, you have the option to repeat it, increasing your reps as you progress.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Customization section
              Text(
                'Customize Your Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Admin users have the ability to add new categories and exercises, which will appear alongside our core challenges. '
                'This ensures a fresh and evolving experience for all users.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Information on additional features
              Text(
                'More Than Just Workouts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We offer valuable insights into gym-related foods, complete with photos and sections for specific goals like cutting. '
                'Additionally, learn about different exercises and their benefits with dedicated sections for Upper Body, Lower Body, and more.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Advice and motivation section
              Text(
                'Advice & Motivation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Stay inspired with our advice section covering topics such as consistency, nutrition, and celebrating progress. '
                'For extra motivation, explore tips on staying positive, setting realistic goals, and enjoying your fitness journey.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Progress tracking section
              Text(
                'Track Your Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our app allows users to favorite exercises, track their BMI, and even restart their progress whenever they choose. '
                'Theme customization and other settings make the app more personalized to your liking.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Admin and user modes
              Text(
                'Admin & User Modes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Seamlessly switch between admin and user modes. Admins can manage exercises and categories, while users enjoy a customized fitness experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              // Thank you message
              Text(
                'Thank you for being a part of our fitness community!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
