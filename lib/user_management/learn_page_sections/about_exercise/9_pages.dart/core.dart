import 'package:flutter/material.dart';

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Exercises Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Abs Exercises
            const Section(
              heading: 'Abs Exercises',
              subtitles: [
                Subtitle(
                  title: 'Crunches',
                  description: 'Crunches primarily target the upper abs. Lie on your back with your knees bent and feet flat on the floor. Place your hands behind your head. Curl your upper body towards your knees, lifting your shoulders off the ground, and then lower back down. Keep your lower back pressed against the floor and avoid pulling on your neck.',
                ),
                Subtitle(
                  title: 'Leg Raises',
                  description: 'Leg raises target the lower abs. Lie on your back with your legs straight and arms at your sides. Lift your legs towards the ceiling while keeping them straight, then slowly lower them back down without touching the floor. Engage your core throughout the movement and avoid arching your lower back.',
                ),
                Subtitle(
                  title: 'Planks',
                  description: 'Planks are a full-core exercise that strengthens both the abs and lower back. Start in a push-up position but rest on your forearms instead of your hands. Keep your body in a straight line from head to heels and hold the position. Ensure your hips do not sag and your body remains in a straight line.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Obliques Exercises
            const Section(
              heading: 'Obliques Exercises',
              subtitles: [
                Subtitle(
                  title: 'Russian Twists',
                  description: 'Russian twists target the obliques and core. Sit on the floor with your knees bent and feet off the ground. Lean back slightly and hold a weight or medicine ball. Twist your torso to the right, then to the left to complete one rep. Engage your core and keep your movements controlled.',
                ),
                Subtitle(
                  title: 'Side Planks',
                  description: 'Side planks focus on the oblique muscles. Lie on your side and lift your body up on one forearm, keeping your body in a straight line. Hold the position and then switch sides. Keep your hips up and avoid letting your body sag.',
                ),
                Subtitle(
                  title: 'Bicycle Crunches',
                  description: 'Bicycle crunches engage both the abs and obliques. Lie on your back with your hands behind your head and legs lifted. Bring your right elbow towards your left knee while extending your right leg. Alternate sides in a pedaling motion. Maintain a slow and controlled pace to maximize muscle engagement.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Lower Back Exercises
            const Section(
              heading: 'Lower Back Exercises',
              subtitles: [
                Subtitle(
                  title: 'Supermans',
                  description: 'Supermans target the lower back muscles. Lie face down on the floor with your arms extended in front of you. Lift your arms, chest, and legs off the ground simultaneously, then lower them back down. Keep your movements controlled and avoid excessive arching of your back.',
                ),
                Subtitle(
                  title: 'Bird Dogs',
                  description: 'Bird dogs improve lower back stability. Start on all fours with your hands under your shoulders and knees under your hips. Extend one arm forward and the opposite leg back, then return to the starting position and switch sides. Keep your core engaged and maintain a neutral spine throughout.',
                ),
                Subtitle(
                  title: 'Back Extensions',
                  description: 'Back extensions strengthen the lower back. Lie face down on a back extension bench or use a stability ball. Hook your feet under the footpads or stabilize your legs, then lift your upper body while keeping your hips stationary. Lower back down slowly. Focus on using your lower back muscles and avoid overextending.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips for Exercise
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.cardColor,
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• Always start with a proper warm-up to prepare your muscles and prevent injury.\n'
                    '• Focus on correct form to maximize effectiveness and reduce the risk of injury.\n'
                    '• Gradually increase the difficulty of the exercises to keep challenging your core.\n'
                    '• Incorporate a mix of exercises to target all areas of your core for balanced development.',
                    style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge!.color,),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
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
            style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge!.color,),
          ),
        ],
      ),
    );
  }
}
