import 'package:flutter/material.dart';

class OffSeason extends StatefulWidget {
  const OffSeason({super.key,required this.heading});
  final String heading;

  @override
  State<OffSeason> createState() => _OffSeasonState();
}

class _OffSeasonState extends State<OffSeason> {

final _foodNames = [
  "Chicken Breast","Turkey","Salmon","Lean Beef","Eggs","Greek Yogurt","Quinoa","Oats","Sweet Potatoes","Nuts and Seeds",
  "Brown Rice","Avocado","Cottage Cheese","Beans and Lentils","Fruits and Vegetables"
];

final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/salmon.jfif',
    'assets/leanbeef.jfif',
    'assets/eggs.jfif',
    'assets/yogurt.jfif',
    'assets/quinoa.jfif',
    'assets/oats.jfif',
    'assets/sweetpotatos.jfif',
    'assets/needsandnuds.jfif',
    'assets/brownrice.jfif',
    'assets/avocado.jfif',
    'assets/cottagecheese.jfif',
    'assets/beansandlentils.jfif',
    'assets/fruitsandvegitables.jfif'
  ];

final _foodExplanations = [
  "Chicken breast is a lean source of high-quality protein, essential for muscle repair and growth. It is low in fat and provides important vitamins like B6, which supports energy metabolism. Additionally, chicken breast is versatile and can be prepared in numerous ways to keep meals interesting.",
  "Similar to chicken breast, turkey is a great source of lean protein. It contains essential amino acids that promote muscle growth and recovery, and it is rich in nutrients like zinc and iron. Turkey can be included in various dishes from salads to stews, providing variety in your diet.",
  "Salmon is rich in protein and healthy fats, particularly omega-3 fatty acids. Omega-3s help reduce inflammation, support heart health, and improve muscle protein synthesis. Salmon also provides vitamin D, which is important for bone health and immune function.",
  "Lean cuts of beef provide high-quality protein and are rich in iron and B vitamins, which are essential for energy production and muscle maintenance. They also contain creatine, which can enhance strength and muscle mass. Lean beef is also a good source of zinc, which supports immune function.",
  "Eggs are a complete protein source, providing all essential amino acids. They also contain healthy fats and vitamins like B12 and choline, which support brain function and overall health. Eggs are highly versatile and can be prepared in various ways to suit your taste.",
  "Greek yogurt is packed with protein and probiotics that support gut health. It also provides calcium, which is important for bone health and muscle function. Greek yogurt can be enjoyed on its own, with fruits, or as a base for smoothies and sauces.",
  "Quinoa is a high-protein grain that also provides complex carbohydrates and fiber. It contains all nine essential amino acids, making it a complete protein source that supports muscle growth and energy levels. Quinoa is also rich in magnesium, which helps with muscle relaxation and recovery.",
  "Oats are an excellent source of complex carbohydrates and fiber, providing sustained energy for workouts. They also contain protein and important vitamins and minerals like magnesium and iron. Oats can be prepared in various forms, such as oatmeal, overnight oats, or added to smoothies and baked goods.",
  "Sweet potatoes are rich in complex carbohydrates, vitamins (especially vitamin A), and minerals. They provide a steady source of energy and support recovery with their antioxidant properties. Sweet potatoes are also a good source of dietary fiber, which aids in digestion and helps maintain stable blood sugar levels.",
  "Nuts and seeds, such as almonds, walnuts, and chia seeds, are high in healthy fats, protein, and fiber. They provide a concentrated source of energy and essential nutrients like vitamin E and magnesium. Nuts and seeds can be eaten as snacks or added to various dishes for extra texture and nutrition.",
  "Brown rice is a whole grain that provides complex carbohydrates, which are essential for fueling intense workouts. It also contains fiber and important minerals like magnesium and selenium. Brown rice is more nutritious than white rice and helps keep you fuller for longer, aiding in overall calorie management.",
  "Avocado is rich in healthy monounsaturated fats, which support heart health and hormone production. It also provides fiber, potassium, and vitamins that promote overall health and recovery. Avocado can be added to salads, sandwiches, or smoothies, or enjoyed on its own.",
  "Cottage cheese is a high-protein dairy product rich in casein protein, which digests slowly and provides a steady supply of amino acids to the muscles. It's also a good source of calcium. Cottage cheese can be paired with fruits or vegetables for a nutritious snack or meal.",
  "Beans and lentils are plant-based protein sources that also provide complex carbohydrates and fiber. They are rich in vitamins and minerals like iron and folate, supporting muscle growth and recovery. Beans and lentils can be used in soups, stews, salads, or as a side dish.",
  "A variety of fruits and vegetables provide essential vitamins, minerals, and antioxidants that support overall health, immune function, and recovery. They also add fiber to the diet, aiding in digestion and nutrient absorption. Incorporating a colorful array of fruits and vegetables ensures you get a broad spectrum of nutrients."
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
