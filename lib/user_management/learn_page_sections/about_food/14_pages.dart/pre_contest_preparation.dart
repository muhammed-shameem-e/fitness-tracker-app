import 'package:flutter/material.dart';

class PreContestPreparation extends StatefulWidget {
const PreContestPreparation({super.key,required this.heading});
  final String heading;

  @override
  State<PreContestPreparation> createState() => _PreContestPreparationState();
}

class _PreContestPreparationState extends State<PreContestPreparation> {

final _foodNames = [
  "Chicken Breast","Turkey Breast","White Fish (e.g., Cod, Tilapia)","Egg Whites","Avocado","Olive Oil","Almonds and Walnuts",
  "Oats","Sweet Potatoes","Quinoa","Leafy Greens (e.g., Spinach, Kale)","Broccoli","Asparagus","Berries (e.g., Blueberries, Strawberries)",
  "Apples","Greek Yogurt","Cottage Cheese"
];

final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/whitefish.jfif',
    'assets/eggs.jfif',
    'assets/avocado.jfif',
    'assets/oliveoil.jfif',
    'assets/almondsandwalnuts.jfif',
    'assets/oats.jfif',
    'assets/sweetpotatos.jfif',
    'assets/quinoa.jfif',
    'assets/leafygreens.jfif',
    'assets/broccoli.jfif',
    'assets/asparagus.jfif',
    'assets/berries.jfif',
    'assets/apples.jfif',
    'assets/yogurt.jfif',
    'assets/cottagecheese.jfif'
  ];

final _foodExplanations = [
  "Chicken breast is a staple in pre-contest diets due to its high protein content and low fat. It supports muscle maintenance while keeping calories low. Additionally, chicken breast is versatile and can be prepared in numerous ways to keep meals interesting. Its rich vitamin B6 content aids in energy metabolism, making it an excellent choice for active individuals.",
  "Like chicken breast, turkey breast is lean and rich in protein, making it an excellent choice for muscle preservation and fat loss. It contains essential amino acids that promote muscle repair and recovery, and it is rich in nutrients like zinc and iron, which support immune function and energy levels.",
  "White fish such as cod and tilapia are very lean and provide high-quality protein with minimal calories and fat, perfect for a calorie-restricted diet. They are also rich in essential nutrients like selenium, which plays a role in antioxidant protection and immune function.",
  "Egg whites are a pure protein source with almost no fat, making them ideal for maintaining muscle mass while cutting calories. They are also low in calories and high in important amino acids, providing essential building blocks for muscle repair and growth.",
  "Avocados provide healthy monounsaturated fats that support hormone production and overall health. They also offer fiber, which aids in digestion and satiety. Avocados are rich in potassium, which helps maintain electrolyte balance and supports muscle function.",
  "Olive oil is a healthy fat source that can be used for cooking or salad dressings. It helps maintain essential fat intake without adding excessive calories. Olive oil contains antioxidants and anti-inflammatory properties that support heart health and overall well-being.",
  "Nuts are rich in healthy fats, protein, and fiber. They provide a concentrated source of energy and essential nutrients, but should be consumed in moderation due to their calorie density. Almonds and walnuts are also rich in vitamin E, which supports skin health and immune function.",
  "Oats are a great source of complex carbohydrates and fiber, providing sustained energy and helping to keep you full longer. They also contain beta-glucan, a type of soluble fiber that can help lower cholesterol levels and improve heart health.",
  "Sweet potatoes are rich in complex carbohydrates, vitamins (especially vitamin A), and minerals. They provide a steady source of energy and support recovery with their antioxidant properties. Sweet potatoes also have anti-inflammatory benefits and can help regulate blood sugar levels.",
  "Quinoa is a complete protein and provides complex carbohydrates and fiber, making it a versatile and nutritious choice. It is also rich in magnesium, which helps with muscle relaxation and recovery. Quinoa contains antioxidants and anti-inflammatory compounds that support overall health.",
  "Leafy greens are low in calories but high in vitamins, minerals, and fiber, making them excellent for volume and nutrient intake without adding calories. They are also rich in antioxidants that protect against cellular damage and support immune function.",
  "Broccoli is high in fiber and essential vitamins, supporting overall health and digestion. It contains sulforaphane, a compound that has been shown to have anti-cancer properties and supports detoxification processes in the body.",
  "Asparagus is low in calories and acts as a natural diuretic, helping to reduce water retention. It is also rich in vitamins A, C, and K, as well as folate, which supports cell function and tissue growth.",
  "Berries are high in antioxidants and fiber, providing a sweet option with minimal impact on blood sugar levels. They also support brain health, reduce inflammation, and improve heart health due to their high polyphenol content.",
  "Apples provide fiber and are relatively low in calories, making them a good option for satisfying sweet cravings. They also contain antioxidants that support heart health and reduce the risk of chronic diseases.",
  "Greek yogurt is high in protein and probiotics, which support gut health and muscle maintenance. It is also rich in calcium, which is important for bone health. Greek yogurt can be used as a base for smoothies, mixed with fruits, or enjoyed on its own.",
  "Cottage cheese is high in casein protein, which digests slowly and provides a steady supply of amino acids to muscles, making it great for maintaining muscle mass. It is also a good source of calcium and other essential nutrients that support overall health and recovery."
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
