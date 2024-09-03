import 'package:flutter/material.dart';

class EnduranceTraining extends StatefulWidget {
  const EnduranceTraining({super.key,required this.heading});
  final String heading;

  @override
  State<EnduranceTraining> createState() => _EnduranceTrainingState();
}

class _EnduranceTrainingState extends State<EnduranceTraining> {

final _foodNames = [
  'Whole Grains','Starchy Vegetables','Lean Meats','Fish','Legumes','Plant-Based Proteins','Fruits','Vegetables','Avocados',
  'Nuts and Seeds','Dairy or Dairy Alternatives','Hydrating Foods'
];

final _foodPhotos = [
    'assets/wholegrainbread.jfif',
    'assets/strachyvegitables.jfif',
    'assets/leanmeats.jfif',
    'assets/fish.jfif',
    'assets/legumes.jfif',
    'assets/plantbasedprotien.jfif',
    'assets/fruitsandvegitables.jfif',
    'assets/fruitsandvegitables.jfif',
    'assets/avocado.jfif',
    'assets/needsandnuds.jfif',
    'assets/dairy.jfif',
    'assets/hydrationfoods.jfif',
  ];

final _foodExplanations=[
  'Whole grains like brown rice, quinoa, and oats provide sustained energy through complex carbohydrates, which release glucose slowly, keeping you energized during long workouts. They also contain fiber, which aids digestion and stabilizes blood sugar levels. Starchy vegetables such as sweet potatoes and potatoes are similarly rich in carbs, helping to fuel workouts and maintain energy levels.',
  
  'Starchy vegetables like sweet potatoes and potatoes are similarly rich in carbs, helping to fuel workouts and maintain energy levels.',
  
  'Lean meats, such as chicken breast and turkey, offer high-quality protein essential for muscle repair and recovery. They also provide iron, which supports oxygen transport in the blood, enhancing endurance. Fish, especially fatty varieties like salmon, are packed with protein and omega-3 fatty acids, which reduce inflammation and aid in recovery.',
  
  'Fish, especially fatty varieties like salmon, are packed with protein and omega-3 fatty acids, which reduce inflammation and aid in recovery.',
  
  'Legumes like lentils and chickpeas are great plant-based protein sources, offering both protein and fiber for muscle repair and digestion. Plant-based options like tofu and tempeh provide good protein content and can be combined to ensure you get all essential amino acids needed for muscle growth.',
  
  'Plant-based options like tofu and tempeh provide good protein content and can be combined to ensure you get all essential amino acids needed for muscle growth.',
  
  'Fruits such as bananas and berries are rich in vitamins and antioxidants, supporting energy levels and recovery. Vegetables like spinach and bell peppers provide essential nutrients and antioxidants that contribute to overall health and endurance.',
  
  'Vegetables like spinach and bell peppers provide essential nutrients and antioxidants that contribute to overall health and endurance.',
  
  'Avocados offer healthy fats, fiber, and potassium, supporting hormone production and muscle function. Nuts and seeds, including almonds and chia seeds, provide protein, healthy fats, and essential minerals that help with muscle growth, repair, and sustained energy.',
  
  'Nuts and seeds, including almonds and chia seeds, provide protein, healthy fats, and essential minerals that help with muscle growth, repair, and sustained energy.',
  
  'Greek yogurt is high in protein and calcium, aiding muscle repair and bone health. Milk and plant-based milks like almond milk also offer protein and calcium, supporting overall recovery and muscle function.',
  
  'Coconut water replenishes electrolytes and helps maintain hydration. Water-rich vegetables like cucumbers and celery contribute to hydration and provide essential vitamins and minerals for recovery and overall health.'
];


  int _currentIndex = 0;
  bool _isForward = true;

  void _previousFood() {
    setState(() {
      _isForward = false;
      _currentIndex = (_currentIndex - 1 + _foodNames.length) % _foodNames.length;
    });
  }

  void _nextFood() {
    setState(() {
      _isForward = true;
      _currentIndex = (_currentIndex + 1) % _foodNames.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_foodPhotos[_currentIndex]),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Align(alignment: Alignment.topCenter,
            child: Text(widget.heading,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white,
             ),
             ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _previousFood,
                  icon: const Icon(Icons.arrow_left, size: 60, color: Colors.white),
                ),
                Expanded(
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: _isForward ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child: Text(
                          _foodNames[_currentIndex],
                          key: ValueKey<int>(_currentIndex),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: _isForward ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child: Text(
                          _foodExplanations[_currentIndex],
                          key: ValueKey<int>(_currentIndex),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _nextFood,
                  icon: const Icon(Icons.arrow_right, size: 60, color: Colors.white),
                ),
              ],
            ),const SizedBox(height: 60),
            Text('${_currentIndex +1}/${_foodPhotos.length}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
