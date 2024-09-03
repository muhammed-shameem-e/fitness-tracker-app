import 'package:flutter/material.dart';

class UpperBody extends StatelessWidget {
  const UpperBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Fetch the current theme
    final isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is enabled

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upper Body Exercise Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
       ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Chest Exercises
            const Section(
              heading: 'Chest Exercises',
              subtitles: [
                Subtitle(
                  title: 'Push-Ups',
                  description: 'Push-ups are a bodyweight exercise that targets the chest, shoulders, and triceps...',
                ),
                Subtitle(
                  title: 'Bench Press',
                  description: 'The bench press is a classic strength training exercise for building upper body strength...',
                ),
                Subtitle(
                  title: 'Dumbbell Flyes',
                  description: 'Dumbbell flyes isolate the chest muscles and enhance their flexibility...',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Shoulder Exercises
            const Section(
              heading: 'Shoulder Exercises',
              subtitles: [
                Subtitle(
                  title: 'Overhead Press',
                  description: 'The overhead press is an effective exercise for building shoulder strength...',
                ),
                Subtitle(
                  title: 'Lateral Raises',
                  description: 'Lateral raises are excellent for targeting the lateral deltoids...',
                ),
                Subtitle(
                  title: 'Front Raises',
                  description: 'Front raises target the anterior deltoids...',
                ),
                Subtitle(
                  title: 'Rear Delt Flyes',
                  description: 'Rear delt flyes focus on the posterior deltoids and upper back...',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Arm Exercises
            const Section(
              heading: 'Arm Exercises',
              subtitles: [
                Subtitle(
                  title: 'Bicep Curls',
                  description: 'Bicep curls are a fundamental exercise for building the biceps...',
                ),
                Subtitle(
                  title: 'Chin-Ups',
                  description: 'Chin-ups are a bodyweight exercise that primarily targets the biceps...',
                ),
                Subtitle(
                  title: 'Tricep Dips',
                  description: 'Tricep dips are a bodyweight exercise that targets the triceps...',
                ),
                Subtitle(
                  title: 'Tricep Pushdowns',
                  description: 'Tricep pushdowns isolate the triceps and can be done with a cable machine...',
                ),
                Subtitle(
                  title: 'Overhead Tricep Extension',
                  description: 'Overhead tricep extensions are effective for targeting the long head of the triceps...',
                ),
                Subtitle(
                  title: 'Skull Crushers',
                  description: 'Skull crushers are an isolation exercise for the triceps...',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tips for Exercise
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDarkMode ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primaryContainer,
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
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Always start with a proper warm-up to prepare your muscles and prevent injury.\n'
                    '• Focus on correct form to maximize effectiveness and reduce the risk of injury.\n'
                    '• Gradually increase the weight or resistance to keep challenging your muscles.\n'
                    '• Allow adequate rest between workouts for muscle recovery and growth.',
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface, // Adjust color based on theme
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
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest, // Background for subtitle boxes
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
              color: theme.colorScheme.primary, // Text color based on theme
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface), // Description color
          ),
        ],
      ),
    );
  }
}
