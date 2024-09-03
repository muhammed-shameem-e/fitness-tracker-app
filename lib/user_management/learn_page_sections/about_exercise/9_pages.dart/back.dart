import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Exercises Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Upper Back Exercises
            const Section(
              heading: 'Upper Back Exercises',
              subtitles: [
                Subtitle(
                  title: 'Reverse Flyes',
                  description: 'Reverse flyes target the upper back and rear deltoids. Bend at the hips with a slight bend in your knees, holding dumbbells in each hand. With palms facing each other, lift the weights out to the sides until your arms are parallel to the ground, then lower back down. Keep a slight bend in your elbows and focus on squeezing your shoulder blades together.',
                ),
                Subtitle(
                  title: 'Face Pulls',
                  description: 'Face pulls strengthen the upper back and rear shoulders. Use a cable machine with a rope attachment set at upper chest level. Pull the rope towards your face, keeping your elbows high and out to the sides. Slowly return to the starting position. Focus on the contraction of the upper back muscles and maintain a controlled movement.',
                ),
                Subtitle(
                  title: 'Bent-Over Rows',
                  description: 'Bent-over rows target the upper back and lats. Stand with your feet shoulder-width apart and a slight bend in your knees. Bend forward at the hips, keeping your back straight. Pull the barbell or dumbbells towards your waist, then lower back down. Keep your back flat and avoid using momentum to lift the weights.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Lower Back Exercises
            const Section(
              heading: 'Lower Back Exercises',
              subtitles: [
                Subtitle(
                  title: 'Deadlifts',
                  description: 'Deadlifts are a compound exercise that targets the lower back, glutes, and hamstrings. Stand with your feet hip-width apart and grip the barbell with an overhand grip. Keeping your back straight, lift the barbell by extending your hips and knees, then lower it back down. Engage your core and maintain a neutral spine throughout the lift.',
                ),
                Subtitle(
                  title: 'Hyperextensions',
                  description: 'Hyperextensions focus on the lower back muscles. Use a hyperextension bench or stability ball. Lie face down with your hips supported and feet anchored. Lift your upper body by extending your lower back, then lower back down. Avoid overextending and maintain control of the movement.',
                ),
                Subtitle(
                  title: 'Good Mornings',
                  description: 'Good mornings strengthen the lower back and hamstrings. Stand with your feet shoulder-width apart and a barbell across your upper back. Bend at the hips while keeping your back straight, then return to the starting position. Keep a slight bend in your knees and avoid rounding your back.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Lats Exercises
            const Section(
              heading: 'Lats Exercises',
              subtitles: [
                Subtitle(
                  title: 'Pull-Ups',
                  description: 'Pull-ups are a primary exercise for developing the lats. Grab a pull-up bar with an overhand grip, hands shoulder-width apart. Pull your body up until your chin is above the bar, then lower back down. Engage your lats and avoid swinging your body.',
                ),
                Subtitle(
                  title: 'Lat Pulldowns',
                  description: 'Lat pulldowns target the lats and upper back. Use a lat pulldown machine with a wide grip attachment. Pull the bar down towards your chest, then slowly release it back up. Lean back slightly and focus on pulling with your lats rather than your arms.',
                ),
                Subtitle(
                  title: 'Single-Arm Dumbbell Rows',
                  description: 'Single-arm dumbbell rows focus on the lats and upper back. Place one knee and hand on a bench for support. With the other hand, lift a dumbbell towards your hip, then lower it back down. Keep your back straight and avoid twisting your torso.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips for Exercise
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
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
                    '• Gradually increase the difficulty of the exercises to keep challenging your muscles.\n'
                    '• Incorporate a mix of exercises to target all areas of your back for balanced development.',
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
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
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
