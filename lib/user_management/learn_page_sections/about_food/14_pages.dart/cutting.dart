import 'package:flutter/material.dart';

class Cutting extends StatefulWidget {
  const Cutting({super.key,required this.heading});
  final String heading;

  @override
  State<Cutting> createState() => _CuttingState();
}

class _CuttingState extends State<Cutting> {
  final _cuttingFoods = [
  'Chicken Breast','Turkey','Fish (Salmon, Tuna)','Egg Whites','Lean Beef','Leafy Greens (Spinach, Kale, Arugula)','Greek Yogurt',
  'Berries (Strawberries, Blueberries, Raspberries)','Quinoa','Nuts and Seeds (Almonds, Chia Seeds)','Cottage Cheese',
  'Green Tea'
];
  final _cuttingFoodExplanations = [
  'Chicken breast is a staple for those aiming to lose fat while preserving muscle mass. It\'s an excellent source of lean protein, which is crucial for muscle repair and growth. Protein helps keep you full, reducing the temptation to snack on high-calorie foods. Chicken breast is low in fat and calories, making it ideal for a cutting diet. Additionally, it contains important vitamins and minerals such as niacin (vitamin B3) and vitamin B6, which support energy metabolism and overall health. Chicken breast is versatile and can be prepared in various ways, ensuring you don’t get bored with your diet.',
  'Turkey, especially the breast meat, is another fantastic lean protein source. It\'s low in fat and high in protein, which supports muscle maintenance and aids in fat loss. Protein also boosts your metabolism and helps control appetite by keeping you full longer. Turkey is rich in essential nutrients like iron, which is vital for oxygen transport in the blood, and zinc, which supports the immune system. Its mild flavor makes it adaptable to many recipes, from salads to stir-fries, helping you stick to your cutting diet without sacrificing taste.',
  'Fish like salmon and tuna are beneficial for cutting due to their high-quality protein and healthy fats, particularly omega-3 fatty acids. Omega-3s reduce inflammation, support heart health, and can aid in fat loss. Salmon is particularly rich in omega-3s and provides a good amount of protein, which helps in muscle preservation. Tuna, while lower in fat, is an excellent lean protein source that offers nutrients like selenium, an antioxidant. Including fish in your diet can help you maintain muscle mass and lose fat, while also promoting overall health.',
  'Egg whites are almost pure protein, making them an excellent food choice for cutting. They are low in calories and fat, providing the necessary amino acids for muscle repair and growth without adding excess calories to your diet. Egg whites are versatile and can be included in various meals, from breakfast omelets to post-workout snacks. They help you meet your protein needs while keeping your calorie intake in check, making it easier to achieve a calorie deficit for fat loss.',
  'Lean cuts of beef, such as sirloin or tenderloin, are rich in protein and essential nutrients like iron and B vitamins. These nutrients support muscle maintenance, energy production, and overall health. Lean beef provides a robust flavor and can be included in various dishes, from stir-fries to salads. Its high protein content helps preserve muscle mass during a calorie deficit, and the iron content is crucial for maintaining energy levels, especially during intense workouts.',
  'Leafy greens like spinach, kale, and arugula are low in calories and high in fiber, vitamins, and minerals. They add volume to your meals without significantly increasing calorie intake, helping you feel full and satisfied. Leafy greens are rich in antioxidants and other nutrients that support overall health and can aid in recovery from workouts. They are versatile and can be added to salads, smoothies, or cooked dishes, making it easy to incorporate them into your diet.',
  'Greek yogurt is rich in protein and low in fat, making it an excellent snack for muscle maintenance during cutting. It also contains probiotics that support gut health and digestion, which is important for overall well-being. Greek yogurt is thicker and contains less sugar than regular yogurt, making it a healthier choice. It\'s also a good source of calcium, which is important for bone health. You can enjoy Greek yogurt on its own, or add it to smoothies, or use it as a base for dips and dressings.',
  'Berries such as strawberries, blueberries, and raspberries are low in calories and high in fiber, vitamins, and antioxidants. They provide natural sweetness and can help satisfy sugar cravings without derailing your diet. Berries are also rich in vitamins like vitamin C, which supports immune function and skin health. The antioxidants in berries help combat oxidative stress and support recovery from exercise. They can be eaten on their own, added to Greek yogurt, or included in smoothies and salads.',
  'Quinoa is a high-protein grain that also provides complex carbohydrates and fiber. It contains all nine essential amino acids, making it a complete protein source. Quinoa helps sustain energy levels and supports muscle recovery and growth, making it an excellent addition to a cutting diet. It\'s also rich in vitamins and minerals like magnesium, iron, and B vitamins, which support overall health. Quinoa is versatile and can be used in salads, as a side dish, or as a base for various meals.',
  'Nuts and seeds, such as almonds and chia seeds, are high in healthy fats, protein, and fiber. They provide a concentrated source of energy and essential nutrients, helping to keep you full and satisfied. Nuts and seeds are rich in vitamins and minerals like vitamin E and magnesium, which support overall health and muscle function. While they are higher in calories, their nutrient density and ability to promote satiety make them a valuable addition to a cutting diet when consumed in moderation.',
  'Cottage cheese is a low-fat, high-protein dairy product that is great for muscle maintenance. It’s rich in casein protein, which digests slowly, providing a steady supply of amino acids to the muscles. Cottage cheese is also a good source of calcium, which is important for bone health. It\'s versatile and can be eaten on its own, mixed with fruits or vegetables, or used as a topping for salads and other dishes.',
  'Green tea is low in calories and contains antioxidants, particularly catechins, which may aid in fat loss. It also provides a small amount of caffeine, which can enhance metabolism and fat burning. Green tea supports overall health and can be a hydrating and refreshing addition to your diet. Drinking green tea can help boost your metabolic rate and promote fat loss while also providing a variety of health benefits.'
];




  final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
    'assets/leanbeef.jfif',
    'assets/greefyleaps.jfif',
    'assets/yogurt.jfif',
    'assets/berries.jfif',
    'assets/quinoa.jfif',
    'assets/needsandnuds.jfif',
    'assets/cottagecheese.jfif',
    'assets/greentea.jfif',
  ];

  int _currentIndex = 0;
  bool _isForward = true;

  void _previousFood() {
    setState(() {
      _isForward = false;
      _currentIndex = (_currentIndex - 1 + _cuttingFoods.length) % _cuttingFoods.length;
    });
  }

  void _nextFood() {
    setState(() {
      _isForward = true;
      _currentIndex = (_currentIndex + 1) % _cuttingFoods.length;
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
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.topCenter,
            child: Text(widget.heading,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white,
             ),textAlign: TextAlign.center,
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
                          _cuttingFoods[_currentIndex],
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
                          _cuttingFoodExplanations[_currentIndex],
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
