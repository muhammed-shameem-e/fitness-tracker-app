import 'package:flutter/material.dart';

class PowerPlyometric extends StatelessWidget {
  const PowerPlyometric({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Power and Plyometric Exercises Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Power Exercises
            const Section(
              heading: 'Power Exercises',
              subtitles: [
                Subtitle(
                  title: 'Box Jumps',
                  description: 'Box jumps are a powerful plyometric exercise that targets the legs and core. Stand in front of a sturdy box or platform. Jump onto the box with both feet, landing softly, then step or jump back down. Focus on explosiveness and maintaining good form throughout the movement.',
                ),
                Subtitle(
                  title: 'Medicine Ball Throws',
                  description: 'Medicine ball throws help develop explosive power in the upper body. Stand with your feet shoulder-width apart, holding a medicine ball. Using your core and upper body, throw the ball against a wall or to a partner with as much force as possible. Catch the ball and repeat.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Plyometric Exercises
            const Section(
              heading: 'Plyometric Exercises',
              subtitles: [
                Subtitle(
                  title: 'Jump Squats',
                  description: 'Jump squats combine strength and explosiveness. Start with a regular squat, then jump as high as possible at the top of the movement. Land softly and go immediately into the next squat. Maintain good form and control throughout the exercise.',
                ),
                Subtitle(
                  title: 'Lateral Bounds',
                  description: 'Lateral bounds improve lateral power and agility. Stand on one leg and jump laterally to the opposite side, landing on the other leg. Use your arms for momentum and maintain balance. Repeat the movement back and forth.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips for Exercise
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tips for Exercise',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• Always start with a proper warm-up to prepare your muscles and prevent injury.\n'
                    '• Focus on correct form to maximize effectiveness and reduce the risk of injury.\n'
                    '• Gradually increase the difficulty of the exercises to keep challenging your muscles.\n'
                    '• Incorporate a mix of exercises to target all areas for balanced development.',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.2),
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
            style: TextStyle(
             color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 16
            ),
          ),
        ],
      ),
    );
  }
}
