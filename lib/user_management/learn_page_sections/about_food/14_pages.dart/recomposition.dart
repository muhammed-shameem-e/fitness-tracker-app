import 'package:flutter/material.dart';

class Recomposition extends StatefulWidget {
  const Recomposition({super.key,required this.heading});
  final String heading;

  @override
  State<Recomposition> createState() => _RecompositionState();
}

class _RecompositionState extends State<Recomposition> {
  final _recompositionFoods = [
  'Chicken Breast','Turkey','Fish (Salmon, Tuna)','Eggs',
];
  final _recompositionFoodExplanations = [
  'Chicken breast is a top choice for maintaining or building muscle with low fat intake. It’s packed with lean protein, crucial for muscle repair and growth. Rich in nutrients like niacin (vitamin B3) and vitamin B6, it supports energy metabolism. Versatile and mild in flavor, it can be easily included in various dishes.',
  'Turkey breast is an excellent lean protein source, low in fat, aiding in muscle maintenance and growth. Rich in iron and zinc, it supports oxygen transport and immune function. Its mild flavor and versatility make it suitable for various dishes, like sandwiches and salads.',
  'Fish like salmon and tuna provide high-quality protein and healthy omega-3 fats, which support heart health and reduce inflammation. Salmon is rich in omega-3s and protein, ideal for muscle repair. Tuna offers protein and nutrients like selenium. Both are low in saturated fat, supporting overall health and fitness goals.',
  'Eggs are nutrient-dense, providing high-quality protein and essential amino acids for muscle maintenance. They are rich in vitamins and minerals, including vitamin B12 for red blood cell production and choline for brain health. The yolk contains healthy fats and vitamin D for bone health. Eggs are versatile and convenient for any meal.',
];


  final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
  ];

  int _currentIndex = 0;
  bool _isForward = true;

  void _previousFood() {
    setState(() {
      _isForward = false;
      _currentIndex = (_currentIndex - 1 + _recompositionFoods.length) % _recompositionFoods.length;
    });
  }

  void _nextFood() {
    setState(() {
      _isForward = true;
      _currentIndex = (_currentIndex + 1) % _recompositionFoods.length;
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
                          _recompositionFoods[_currentIndex],
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
                          _recompositionFoodExplanations[_currentIndex],
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
