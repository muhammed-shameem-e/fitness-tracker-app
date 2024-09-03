import 'package:flutter/material.dart';

class Advices extends StatelessWidget {
  const Advices({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme and determine if it's dark mode
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Advices',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Advice sections with different topics
            _buildAdviceSection(
              context,
              icon: Icons.access_time,
              title: 'Consistency is Key',
              content: 'Building a healthy lifestyle isn\'t about short bursts of effort—it\'s about making exercise and good nutrition a regular part of your routine. Aim for a balanced workout schedule that includes both cardio exercises like running or cycling to get your heart pumping, and strength training like lifting weights or doing bodyweight exercises to build and tone muscles.',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
            const SizedBox(height: 20),
            _buildAdviceSection(
              context,
              icon: Icons.healing,
              title: 'Listen to Your Body',
              content: 'Push yourself, but know your limits. It\'s normal to feel soreness after a good workout, but pain could be a sign of injury. Rest when you need to and don\'t hesitate to ask for guidance from our trainers on proper form and technique to prevent injuries and get the most out of your workouts.',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
            const SizedBox(height: 20),
            _buildAdviceSection(
              context,
              icon: Icons.local_dining,
              title: 'Nutrition',
              content: 'Fuel your body with wholesome foods like lean proteins, fruits, vegetables, and whole grains. These provide the energy and nutrients needed for workouts and aid in muscle recovery. Stay hydrated by drinking plenty of water throughout the day.',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
            const SizedBox(height: 20),
            _buildAdviceSection(
              context,
              icon: Icons.flag,
              title: 'Celebrate Progress',
              content: 'Progress takes time. Celebrate small victories along the way, whether it\'s lifting a heavier weight or running an extra mile. Stay patient and trust the process. Set realistic goals that are specific, measurable, and achievable, and track your progress to stay motivated.',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
            const SizedBox(height: 20),
            _buildAdviceSection(
              context,
              icon: Icons.group,
              title: 'Support Each Other',
              content: 'Our gym is a community where we can encourage and inspire each other to reach our fitness goals. Share your successes, offer a helping hand to beginners, and celebrate each other\'s achievements.',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
            const SizedBox(height: 20),
            _buildAdviceSection(
              context,
              icon: Icons.star,
              title: 'Final Thoughts',
              content: 'Together, let\'s commit to our health and well-being, and make each workout count. Whether you\'re here to lose weight, gain muscle, or simply improve your overall fitness, know that every effort you put in today brings you closer to a healthier and happier tomorrow. Thank you, and let\'s make this journey toward fitness an amazing one!',
              color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
            ),
          ],
        ),
      ),
    );
  }

  // Builds a single advice section with an icon, title, content, and background color
  Widget _buildAdviceSection(BuildContext context, {required IconData icon, required String title, required String content, required Color color}) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge!.color,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
