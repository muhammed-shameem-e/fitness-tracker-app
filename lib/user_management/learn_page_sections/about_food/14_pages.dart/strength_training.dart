import 'package:flutter/material.dart';

class StrengthTraining extends StatefulWidget {
  const StrengthTraining({super.key,required this.heading});
  final String heading;

  @override
  State<StrengthTraining> createState() => _StrengthTrainingState();
}

class _StrengthTrainingState extends State<StrengthTraining> {

final _foodNames = [
  "Lean meats","Fish","Eggs","Dairy","Legumes","Plant-based protein","Whole grains","Starchy vegetables","Fruits","Avocados",
  "Nuts and seeds","Olive oil","Vegetables",
];

final _foodPhotos = [
    'assets/leanmeats.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
    'assets/dairy.jfif',
    'assets/legumes.jfif',
    'assets/plantbasedprotien.jfif',
    'assets/wholegrainbread.jfif',
    'assets/strachyvegitables.jfif',
    'assets/fruitsandvegitables.jfif',
    'assets/avocado.jfif',
    'assets/needsandnuds.jfif',
    'assets/oliveoil.jfif',
    'assets/fruitsandvegitables.jfif',
  ];

final _foodExplanations= [
  'Lean meats are excellent sources of high-quality protein, the building block of muscle tissue. They provide essential amino acids necessary for muscle growth, repair, and recovery. Additionally, lean meats contain iron, which is crucial for oxygen transport to muscles, enhancing endurance and performance. Opt for cuts of beef, pork, and lamb that are low in saturated fat to maximize benefits.',
  
  'Fish, particularly fatty fish like salmon, mackerel, and tuna, offer a potent combination of protein and omega-3 fatty acids. Protein supports muscle building, while omega-3s are renowned for their anti-inflammatory properties, which can aid in muscle recovery and reduce soreness. Additionally, fish provides essential vitamins like vitamin D, crucial for calcium absorption and overall bone health, indirectly supporting strength training performance.',
  
  'Whole eggs are a complete protein source, containing all essential amino acids for optimal muscle growth. They also provide vital nutrients like vitamin D, B vitamins, and choline, which support various bodily functions including energy metabolism, brain health, and muscle function. The egg yolk, often overlooked, is rich in healthy fats and antioxidants, contributing to overall health and potentially aiding in recovery.',
  
  'Dairy products, such as Greek yogurt, cottage cheese, and milk, offer a blend of protein and calcium. Protein supports muscle building and repair, while calcium is essential for bone health, which indirectly impacts strength and power output. Dairy also provides other essential nutrients like vitamin D, riboflavin, and potassium, contributing to overall well-being and performance.',
  
  'Legumes, including lentils, chickpeas, and beans, are plant-based protein powerhouses, rich in fiber and essential nutrients. The protein content supports muscle growth and repair, while the fiber aids digestion, promotes satiety, and helps regulate blood sugar levels. Legumes also offer iron, magnesium, and zinc, which are crucial for energy production and muscle function.',
  
  'Plant-based protein sources like tofu, tempeh, and seitan provide a viable alternative for vegetarians and vegans. They offer a good amount of protein for muscle building, along with fiber, iron, and other essential nutrients. Combining different plant-based protein sources can help ensure you consume all essential amino acids.',
  
  'Whole grains provide complex carbohydrates, which are the body\'s primary energy source. They offer sustained energy levels during workouts, preventing energy crashes. Additionally, whole grains are rich in fiber, promoting digestive health and aiding in blood sugar control. They also contain essential vitamins, minerals, and antioxidants, supporting overall health and recovery.',
  
  'Starchy vegetables like sweet potatoes, potatoes, and corn are a good source of carbohydrates, providing energy for workouts. They also offer fiber, vitamins, and minerals, contributing to overall health and well-being. While often considered a complex carbohydrate, they should be consumed in moderation and balanced with other food groups for optimal nutrition.',
  
  'Fruits are packed with vitamins, minerals, antioxidants, and fiber. They support immune function, aid in digestion, and provide essential nutrients for overall health. While not a primary protein source, fruits offer valuable micronutrients that contribute to recovery and overall well-being.',
  
  'Avocados are a unique fruit rich in healthy monounsaturated fats, fiber, and potassium. The healthy fats support hormone production, nutrient absorption, and cell repair. Fiber aids digestion and promotes satiety, while potassium is essential for muscle function and nerve impulses.',
  
  'Nuts and seeds are powerhouses of nutrition, offering a combination of protein, healthy fats, fiber, and essential nutrients. The protein supports muscle growth and repair, while the healthy fats contribute to hormone production and cell health. Fiber aids digestion and promotes satiety, while essential nutrients like magnesium, zinc, and selenium support various bodily functions.',
  
  'Olive oil is a staple in the Mediterranean diet, rich in monounsaturated fats. These healthy fats support heart health, reduce inflammation, and may aid in fat loss. Olive oil can be used for cooking or as a dressing, adding flavor and nutritional value to meals.',
  
  'Vegetables are a vital component of a healthy diet, offering a wide range of vitamins, minerals, and fiber. They support immune function, aid in digestion, and provide essential nutrients for overall health and well-being. While not a primary protein source, they offer valuable micronutrients that contribute to recovery and overall performance.'
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
