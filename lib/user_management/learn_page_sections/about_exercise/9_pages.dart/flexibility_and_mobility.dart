import 'package:flutter/material.dart';

class FlexibilityMobility extends StatelessWidget {
  const FlexibilityMobility({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexibility & Mobility Exercises Guide'),
       backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Stretching Exercises
            const Section(
              heading: 'Stretching Exercises',
              subtitles: [
                Subtitle(
                  title: 'Hamstring Stretch',
                  description: 'Sit on the floor with your legs extended. Reach forward towards your toes, keeping your back straight. Hold for 20-30 seconds, feeling the stretch in the back of your legs.',
                ),
                Subtitle(
                  title: 'Quadriceps Stretch',
                  description: 'Stand on one leg, pulling the other foot towards your buttocks. Keep your knees together and hold for 20-30 seconds. Switch legs and repeat.',
                ),
                Subtitle(
                  title: 'Shoulder Stretch',
                  description: 'Bring one arm across your body and use the other arm to pull it closer to your chest. Hold for 20-30 seconds, feeling the stretch in your shoulder. Switch arms and repeat.',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Yoga Exercises
            const Section(
              heading: 'Yoga Exercises',
              subtitles: [
                Subtitle(
                  title: 'Downward Dog',
                  description: 'Start on your hands and knees. Lift your hips towards the ceiling, straightening your legs and arms. Hold for 20-30 seconds, feeling the stretch in your hamstrings and shoulders.',
                ),
                Subtitle(
                  title: 'Child\'s Pose',
                  description: 'Kneel on the floor and sit back on your heels. Extend your arms forward and lower your forehead to the ground. Hold for 20-30 seconds, relaxing your back and shoulders.',
                ),
                Subtitle(
                  title: 'Warrior II',
                  description: 'Stand with your feet wide apart. Turn your right foot out and bend your right knee, keeping your left leg straight. Extend your arms out to the sides and hold for 20-30 seconds. Switch sides and repeat.',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pilates Exercises
            const Section(
              heading: 'Pilates Exercises',
              subtitles: [
                Subtitle(
                  title: 'The Hundred',
                  description: 'Lie on your back with your legs lifted to a tabletop position. Lift your head and shoulders off the ground and pump your arms up and down for a count of 100. Focus on engaging your core throughout the exercise.',
                ),
                Subtitle(
                  title: 'Roll-Up',
                  description: 'Lie on your back with your arms extended overhead. Slowly roll up to a seated position, reaching for your toes. Then, roll back down to the starting position. Perform 5-10 repetitions, focusing on a controlled movement.',
                ),
                Subtitle(
                  title: 'Single Leg Stretch',
                  description: 'Lie on your back with your legs lifted and bent at 90 degrees. Extend one leg out while pulling the other knee towards your chest. Switch legs and continue alternating for 10-20 repetitions.',
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
                    '• Always warm up before starting your stretching or mobility routine to prevent injury.\n'
                    '• Perform each stretch or exercise with proper form and control to maximize effectiveness.\n'
                    '• Breathe deeply and maintain a steady rhythm during each movement.\n'
                    '• Gradually increase the duration and intensity of your exercises to improve flexibility and mobility over time.',
                    style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge!.color,),
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
