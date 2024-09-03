import 'package:flutter/material.dart';

class Motivation extends StatelessWidget {
  const Motivation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme and determine if it's dark mode
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Motivation',
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
            _buildIntroText(theme, isDarkMode),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.star,
              title: 'Celebrate Your Progress',
              content: "Firstly, I commend each of you for showing up. Making the decision to prioritize your health and fitness is a powerful step in itself. Remember, every time you walk through these doors, you're investing in yourself. You're saying yes to a healthier, stronger version of you.",
            ),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.trending_up,
              title: 'Embrace the Challenge',
              content: "I know starting can be tough. It might feel like a mountain to climb, but remember, every step forward counts. Celebrate your progress, no matter how small it may seem. Whether it's holding a plank a few seconds longer, lifting a heavier weight, or running that extra lap, each effort builds your strength and resilience.",
            ),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.assessment,
              title: 'Set Realistic Goals',
              content: "Set realistic goals for yourself. Make them specific and achievable. Break them down into smaller milestones so you can track your progress and celebrate your successes along the way. This journey is about continuous improvement, not perfection.",
            ),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.repeat,
              title: 'Stay Consistent',
              content: "Stay consistent. Consistency is key to reaching your goals. Show up, even on days when motivation is low. Trust the process and believe in your ability to grow stronger with each workout.",
            ),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.group,
              title: 'Surround Yourself with Positivity',
              content: "Surround yourself with positivity. Our gym is more than just a place to exercise—it's a supportive community. Encourage each other, cheer on your fellow gym members, and draw inspiration from their journeys. Together, we can achieve more than we ever could alone.",
            ),
            const SizedBox(height: 20),
            _buildMotivationSection(
              context,
              icon: Icons.emoji_events,
              title: 'Enjoy the Journey',
              content: "Lastly, remember to enjoy the journey. Fitness is not just about physical transformation; it's about feeling good, inside and out. Find activities you love, whether it's lifting weights, dancing, or practicing yoga. Embrace the challenge, and have fun with it!",
            ),
            const SizedBox(height: 20),
            _buildClosingText(theme, isDarkMode),
          ],
        ),
      ),
    );
  }

  // Builds the introductory text widget
  Widget _buildIntroText(ThemeData theme, bool isDarkMode) {
    return Container(
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
      child: Text(
        "Hyy Person, and welcome to our gym community! Whether you're stepping into this journey for the first time or you're a seasoned gym-goer, I want to share some words of motivation with each of you today.",
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontStyle: FontStyle.italic,
          fontSize: 18,
          height: 1.5,
        ),
      ),
    );
  }

  // Builds a single motivation section with an icon, title, and content
  Widget _buildMotivationSection(BuildContext context, {required IconData icon, required String title, required String content}) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Container(
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

  // Builds the closing text widget
  Widget _buildClosingText(ThemeData theme, bool isDarkMode) {
    return Container(
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
      child: Text(
        "As you leave here today, know that you have the power to rewrite your story. Believe in yourself, stay dedicated, and embrace the sweat and effort—it's all part of the path to a healthier, happier you.\n\nThank you all for being here and for being part of our incredible gym family. Let's make every workout count, and let's make this journey towards fitness an inspiring and fulfilling one!",
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontStyle: FontStyle.italic,
          fontSize: 18,
          height: 1.5,
        ),
      ),
    );
  }
}
