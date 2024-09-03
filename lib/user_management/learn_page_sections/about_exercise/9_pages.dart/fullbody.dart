import 'package:flutter/material.dart';

class FullBody extends StatelessWidget {
  const FullBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Body Exercises Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Compound Movements
            const Section(
              heading: 'Compound Movements',
              subtitles: [
                Subtitle(
                  title: 'Burpees',
                  description: 'Burpees are a full-body exercise that works your arms, chest, quads, glutes, hamstrings, and core. Start in a standing position, drop into a squat with your hands on the ground, kick your feet back into a plank position, perform a push-up, jump your feet back to the squat position, and explosively jump into the air reaching your arms overhead.',
                ),
                Subtitle(
                  title: 'Deadlifts',
                  description: 'Deadlifts target the entire posterior chain, including the back, glutes, and hamstrings. Stand with your feet hip-width apart and grip the barbell with an overhand grip. Keeping your back straight, lift the barbell by extending your hips and knees, then lower it back down. Engage your core and maintain a neutral spine throughout the lift.',
                ),
                Subtitle(
                  title: 'Squats',
                  description: 'Squats are a key lower-body exercise that also engages the core and back. Stand with your feet shoulder-width apart, toes slightly turned out. Lower your body by bending your knees and hips, keeping your chest up and back straight. Go down until your thighs are parallel to the ground, then push through your heels to return to the starting position.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips for Exercise
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tips for Exercise',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Always start with a proper warm-up to prepare your muscles and prevent injury.\n'
                    '• Focus on correct form to maximize effectiveness and reduce the risk of injury.\n'
                    '• Gradually increase the difficulty of the exercises to keep challenging your muscles.\n'
                    '• Incorporate a mix of exercises to target all areas of your body for balanced development.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String heading;
  final List<Subtitle> subtitles;

  const Section({super.key, required this.heading, required this.subtitles});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        ...subtitles.map((subtitle) => subtitle),
      ],
    );
  }
}

class Subtitle extends StatelessWidget {
  final String title;
  final String description;

  const Subtitle({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge!.color,),
          ),
        ],
      ),
    );
  }
}
