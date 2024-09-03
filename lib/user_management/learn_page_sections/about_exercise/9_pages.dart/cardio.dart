import 'package:flutter/material.dart';

class Cardio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardio Exercises Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Running Exercises
            const Section(
              heading: 'Running',
              subtitles: [
                Subtitle(
                  title: 'Description',
                  description: 'Running is a high-impact cardio exercise that increases your heart rate, burns calories, and improves cardiovascular health. It can be done outdoors on a track, trail, or pavement, or indoors on a treadmill.',
                ),
                Subtitle(
                  title: 'How to Perform',
                  description: '• Warm-Up: Start with a light jog or brisk walk for 5-10 minutes.\n'
                               '• Form: Maintain an upright posture and use a natural arm swing.\n'
                               '• Pace: Start with a comfortable pace and gradually increase speed.\n'
                               '• Cool-Down: Slow down to a walk for 5-10 minutes, followed by stretching.',
                ),
                Subtitle(
                  title: 'Benefits',
                  description: '• Enhances cardiovascular health\n'
                               '• Burns a significant number of calories\n'
                               '• Improves mental health and mood',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Cycling Exercises
            const Section(
              heading: 'Cycling',
              subtitles: [
                Subtitle(
                  title: 'Description',
                  description: 'Cycling is a low-impact cardio exercise that is easy on the joints while providing an effective workout for the cardiovascular system. It can be performed on a stationary bike or a road bike.',
                ),
                Subtitle(
                  title: 'How to Perform',
                  description: '• Warm-Up: Pedal at a low intensity for 5-10 minutes.\n'
                               '• Form: Adjust the bike seat for proper leg extension.\n'
                               '• Intensity: Alternate between high and low intensity.\n'
                               '• Cool-Down: Gradually reduce intensity and stretch your legs.',
                ),
                Subtitle(
                  title: 'Benefits',
                  description: '• Low-impact on the joints\n'
                               '• Builds leg strength and endurance\n'
                               '• Can be performed indoors or outdoors',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Jump Rope Exercises
            const Section(
              heading: 'Jump Rope',
              subtitles: [
                Subtitle(
                  title: 'Description',
                  description: 'Jump rope is a high-intensity cardio exercise that improves cardiovascular endurance, agility, and coordination. It is a compact and portable exercise option.',
                ),
                Subtitle(
                  title: 'How to Perform',
                  description: '• Warm-Up: Jump slowly or march in place for 2-3 minutes.\n'
                               '• Form: Hold the rope handles with elbows close to your body.\n'
                               '• Pace: Start with short intervals of jumping, then increase duration.\n'
                               '• Cool-Down: Slow jump or walk, and stretch calves, hamstrings, and shoulders.',
                ),
                Subtitle(
                  title: 'Benefits',
                  description: '• Enhances cardiovascular fitness\n'
                               '• Improves coordination and agility\n'
                               '• Burns calories quickly',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tips for Cardio Exercise
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
                    'Tips for Cardio Exercise',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Stay hydrated before, during, and after your workout.\n'
                    '• Choose a cardio exercise that you enjoy to stay motivated.\n'
                    '• Incorporate intervals to enhance cardiovascular fitness.\n'
                    '• Ensure proper footwear and equipment to avoid injuries.',
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
