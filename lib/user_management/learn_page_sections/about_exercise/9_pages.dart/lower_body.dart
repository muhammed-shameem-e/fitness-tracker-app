import 'package:flutter/material.dart';

class LowerBody extends StatelessWidget {
  const LowerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lower Body Exercise Guide'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Leg Exercises
            const Section(
              heading: 'Leg Exercises',
              subtitles: [
                Subtitle(
                  title: 'Squats',
                  description: 'Squats are a fundamental lower body exercise that targets the quadriceps, hamstrings, and glutes. Stand with your feet shoulder-width apart and your toes slightly turned out. Bend your knees and lower your hips as if you’re sitting back into a chair, keeping your chest up and your back straight. Lower down until your thighs are parallel to the floor (or as low as you can go), then push through your heels to return to the starting position.',
                ),
                Subtitle(
                  title: 'Leg Press',
                  description: 'The leg press machine isolates and strengthens the quadriceps. Sit on the machine with your back against the pad and your feet placed shoulder-width apart on the footplate. Push the weight away by extending your legs, then slowly lower it back down by bending your knees. Ensure your knees track in line with your toes throughout the movement.',
                ),
                Subtitle(
                  title: 'Lunges',
                  description: 'Lunges work the quadriceps, hamstrings, and glutes. Stand with your feet together, then take a large step forward with one leg and lower your body until both knees are bent at 90-degree angles. The back knee should hover just above the ground. Push off the front foot to return to the starting position and repeat on the other side.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Hamstring Exercises
            const Section(
              heading: 'Hamstring Exercises',
              subtitles: [
                Subtitle(
                  title: 'Deadlifts',
                  description: 'Deadlifts are a compound movement targeting the hamstrings, glutes, and lower back. Stand with your feet hip-width apart and grip a barbell in front of you. Keep your back straight as you bend at the hips and knees to lower the barbell towards the floor. Lift the barbell by extending your hips and knees until you’re standing upright.',
                ),
                Subtitle(
                  title: 'Hamstring Curls',
                  description: 'Hamstring curls isolate the hamstrings using a machine. Lie face down on the hamstring curl machine with your legs extended and your ankles secured under the pad. Curl your legs up towards your glutes by bending your knees, then slowly lower them back down.',
                ),
                Subtitle(
                  title: 'Romanian Deadlifts',
                  description: 'Romanian deadlifts focus on the hamstrings and glutes. Stand with your feet hip-width apart holding a barbell or dumbbells. Keep a slight bend in your knees and hinge at your hips, lowering the weights while keeping your back straight. Return to the starting position by engaging your hamstrings and glutes.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Glute Exercises
            const Section(
              heading: 'Glute Exercises',
              subtitles: [
                Subtitle(
                  title: 'Hip Thrusts',
                  description: 'Hip thrusts are effective for targeting the glutes. Sit on the floor with your upper back resting against a bench and a barbell across your hips. Roll the barbell into position and press your hips up towards the ceiling, squeezing your glutes at the top. Lower your hips back down and repeat.',
                ),
                Subtitle(
                  title: 'Glute Bridges',
                  description: 'Glute bridges are similar to hip thrusts but performed on the floor. Lie on your back with your knees bent and feet flat on the floor. Push through your heels to lift your hips towards the ceiling, squeezing your glutes at the top. Lower your hips back down and repeat.',
                ),
                Subtitle(
                  title: 'Step-Ups',
                  description: 'Step-ups target the glutes and quads. Stand in front of a bench or elevated platform and place one foot on it. Push through the heel of the elevated foot to step up, bringing the other foot up to join it. Step back down and repeat on the other side.',
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Calf Exercises
            const Section(
              heading: 'Calf Exercises',
              subtitles: [
                Subtitle(
                  title: 'Calf Raises',
                  description: 'Calf raises are a simple yet effective exercise for the calves. Stand with your feet shoulder-width apart and your weight evenly distributed. Rise onto the balls of your feet, squeezing your calves at the top, then slowly lower back down. Variations include standing calf raises and seated calf raises.',
                ),
                Subtitle(
                  title: 'Seated Calf Raises',
                  description: 'Seated calf raises specifically target the soleus muscle of the calves. Sit on a calf raise machine or bench with your knees bent and feet placed on the edge of a block or platform. Press through the balls of your feet to lift the weight, then lower back down.',
                ),
                Subtitle(
                  title: 'Donkey Calf Raises',
                  description: 'Donkey calf raises are performed with your torso leaning forward and your feet on an elevated platform. Place a weight or resistance on your lower back (using a weight belt or partner). Raise your heels as high as possible, then lower back down.',
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
                    '• Gradually increase the weight or resistance to keep challenging your muscles.\n'
                    '• Allow adequate rest between workouts for muscle recovery and growth.',
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
