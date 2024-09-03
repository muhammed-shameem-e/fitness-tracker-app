import 'package:flutter/material.dart';

class Functional extends StatelessWidget {
  const Functional({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Functional Training Guide'),
       backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Balance Exercises
            const Section(
              heading: 'Balance Exercises',
              subtitles: [
                Subtitle(
                  title: 'Single-Leg Deadlift',
                  description: 'The single-leg deadlift improves balance and strengthens the lower body. Stand on one leg, with the other leg slightly raised behind you. Hinge at the hips and lower your torso while extending the raised leg backward. Return to the starting position and repeat on the other side.',
                ),
                Subtitle(
                  title: 'BOSU Ball Squats',
                  description: 'BOSU ball squats enhance balance and lower body strength. Stand on a BOSU ball with feet shoulder-width apart. Perform a squat by bending your knees and lowering your hips, then return to the starting position. Focus on maintaining balance throughout the movement.',
                ),
                Subtitle(
                  title: 'Standing Calf Raises',
                  description: 'Standing calf raises improve balance and strengthen the calves. Stand on one leg and raise your heel as high as possible, then lower it back down. Use a wall or chair for support if needed. Repeat on the other leg.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Coordination Exercises
            const Section(
              heading: 'Coordination Exercises',
              subtitles: [
                Subtitle(
                  title: 'Ladder Drills',
                  description: 'Ladder drills enhance coordination and footwork. Use an agility ladder and perform various stepping patterns such as in-and-out, side-to-side, and crossover steps. Focus on quick, precise movements.',
                ),
                Subtitle(
                  title: 'Juggling',
                  description: 'Juggling improves hand-eye coordination and concentration. Start with two balls and practice tossing them between your hands. Progress to three balls as you become more comfortable. Focus on maintaining a steady rhythm.',
                ),
                Subtitle(
                  title: 'Medicine Ball Toss',
                  description: 'The medicine ball toss enhances coordination and upper body strength. Stand facing a wall or a partner. Toss a medicine ball back and forth, focusing on accuracy and control. Use a variety of tosses such as chest passes and overhead throws.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Agility Exercises
            const Section(
              heading: 'Agility Exercises',
              subtitles: [
                Subtitle(
                  title: 'Cone Drills',
                  description: 'Cone drills improve agility and quickness. Set up cones in various patterns such as zigzag, T-drill, and box drill. Sprint, shuffle, and backpedal between the cones, focusing on sharp changes in direction.',
                ),
                Subtitle(
                  title: 'High Knees',
                  description: 'High knees enhance agility and cardiovascular fitness. Run in place while lifting your knees as high as possible. Focus on quick, explosive movements and maintain an upright posture.',
                ),
                Subtitle(
                  title: 'Lateral Shuffles',
                  description: 'Lateral shuffles improve agility and lateral movement. Stand with feet shoulder-width apart and bend your knees slightly. Shuffle to the side quickly, then shuffle back to the starting position. Keep your hips low and avoid crossing your feet.',
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
                    '• Incorporate a mix of exercises to target all aspects of functional training for balanced development.',
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
