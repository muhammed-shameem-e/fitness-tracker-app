import 'package:flutter/material.dart';

class LearnBulking extends StatefulWidget {
 const LearnBulking({super.key,required this.heading});
  final String heading;

  @override
  State<LearnBulking> createState() => _LearnBulkingState();
}

class _LearnBulkingState extends State<LearnBulking> {
  final _leanBulkingFoods = [
  'Chicken Breast','Turkey','Fish (Salmon, Tuna)','Eggs','Lean Beef','Quinoa','Greek Yogurt','Nuts and Seeds'
];
  final _leanBulkingFoodExplanations = [
  'Chicken breast is a staple for lean bulking due to its high protein content and low fat. Protein is essential for muscle repair and growth, and chicken breast provides a significant amount without adding extra fat. It\'s also rich in vitamins like niacin and B6, supporting energy metabolism.',
  'Turkey, particularly the breast meat, is another excellent source of lean protein. It helps build and maintain muscle mass while keeping fat intake low. Turkey also provides important nutrients like iron, which is essential for oxygen transport in the blood, and zinc, which supports the immune system.',
  'Fish like salmon and tuna are perfect for lean bulking due to their high-quality protein and healthy fats, especially omega-3 fatty acids. Omega-3s reduce inflammation and support heart health. Salmon is particularly beneficial with its higher omega-3 content, while tuna provides lean protein and selenium.',
  'Eggs are a complete source of protein, containing all essential amino acids necessary for muscle growth. They also provide vitamins and minerals such as B12, important for red blood cell production, and choline for brain health. The yolk contains healthy fats and additional vitamins like vitamin D.',
  'Lean cuts of beef, such as sirloin or tenderloin, are rich in protein and essential nutrients like iron and B vitamins. These nutrients support muscle growth and energy production. Lean beef provides a robust flavor and can be included in various dishes, making it a versatile option for a lean bulking diet.',
  'Quinoa is a high-protein grain that also provides complex carbohydrates and fiber. It contains all nine essential amino acids, making it a complete protein source. Quinoa helps sustain energy levels and supports muscle recovery and growth, making it an excellent addition to a lean bulking diet.',
  'Greek yogurt is rich in protein and provides probiotics that support gut health. It\'s thicker and contains less sugar than regular yogurt, making it a healthier choice. Greek yogurt also provides calcium, which is important for bone health, and can be a great snack or addition to meals.',
  'Nuts and seeds, such as almonds and chia seeds, are high in healthy fats, protein, and fiber. They provide a concentrated source of energy and essential nutrients like vitamin E and magnesium. Including nuts and seeds in your diet can help meet your calorie and nutrient needs for lean bulking.'
];



  final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
    'assets/leanbeef.jfif',
    'assets/quinoa.jfif',
    'assets/yogurt.jfif',
    'assets/needsandnuds.jfif',
  ];

  int _currentIndex = 0;
  bool _isForward = true;

  void _previousFood() {
    setState(() {
      _isForward = false;
      _currentIndex = (_currentIndex - 1 + _leanBulkingFoods.length) % _leanBulkingFoods.length;
    });
  }

  void _nextFood() {
    setState(() {
      _isForward = true;
      _currentIndex = (_currentIndex + 1) % _leanBulkingFoods.length;
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
                          _leanBulkingFoods[_currentIndex],
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
                          _leanBulkingFoodExplanations[_currentIndex],
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
