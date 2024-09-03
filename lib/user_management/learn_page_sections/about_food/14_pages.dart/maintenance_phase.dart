import 'package:flutter/material.dart';

class MaintenancePhase extends StatefulWidget {
  const MaintenancePhase({super.key,required this.heading});
  final String heading;

  @override
  State<MaintenancePhase> createState() => _MaintenancePhaseState();
}

class _MaintenancePhaseState extends State<MaintenancePhase> {

final _foodNames = [
  "Chicken Breast","Turkey","Salmon","Lean Beef","Eggs","Greek Yogurt","Quinoa","Oats","Sweet Potatoes","Nuts and Seeds",
  "Brown Rice","Avocado","Cottage Cheese","Beans and Lentils","Fruits and Vegetables","Whole Grain Bread","Chia Seeds"
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
    'assets/fruitsandvegitables.jfif',
    'assets/wholegrainbread.jfif',
    'assets/chiaseeds.jfif',
  ];

final _foodExplanations= [
  "Chicken breast is a lean source of high-quality protein, essential for muscle maintenance and repair. It is low in fat and provides vitamins like B6, which supports energy metabolism. Additionally, chicken breast is versatile and can be prepared in numerous ways to keep meals interesting and flavorful without adding unnecessary calories.",
  "Turkey is another lean protein source rich in essential amino acids, zinc, and iron, promoting muscle maintenance and immune function. It contains tryptophan, which helps produce serotonin, improving mood and sleep quality. Turkey is also low in saturated fat, making it a heart-healthy protein option.",
  "Salmon is rich in protein and omega-3 fatty acids, which help reduce inflammation, support heart health, and enhance muscle protein synthesis. It also provides vitamin D, which is important for bone health and immune function. The healthy fats in salmon support brain health and can help improve cognitive function.",
  "Lean beef offers high-quality protein, iron, and B vitamins, crucial for energy production and muscle maintenance. It also contains creatine, which can enhance muscle strength and performance during workouts. Lean beef is also a good source of zinc, which supports immune function and aids in healing and recovery.",
  "Eggs are a complete protein source, providing all essential amino acids. They also contain healthy fats and vitamins like B12 and choline, which support brain function and overall health. The antioxidants lutein and zeaxanthin in eggs help protect eye health and reduce the risk of age-related macular degeneration.",
  "Greek yogurt is high in protein and probiotics, supporting gut health and digestion. It also provides calcium, essential for bone health and muscle function. Greek yogurt can help maintain a healthy weight by promoting fullness and reducing appetite. It is also a versatile ingredient for smoothies, snacks, and recipes.",
  "Quinoa is a complete protein source, providing all nine essential amino acids. It is rich in fiber, magnesium, and B vitamins, supporting muscle recovery and energy levels. Quinoa is also gluten-free, making it suitable for those with gluten intolerance or celiac disease. It has a low glycemic index, which helps maintain stable blood sugar levels.",
  "Oats are a great source of complex carbohydrates and fiber, providing sustained energy. They also contain protein, magnesium, and iron, aiding in overall health and recovery. The beta-glucan fiber in oats helps lower cholesterol levels and supports heart health. Oats are also known for their anti-inflammatory properties, which can benefit those with chronic conditions.",
  "Sweet potatoes are rich in complex carbohydrates, vitamins (especially vitamin A), and minerals. They provide stable energy and support recovery with their antioxidant properties. The high fiber content aids in digestion and helps maintain stable blood sugar levels. Sweet potatoes are also rich in potassium, which helps regulate blood pressure and fluid balance.",
  "Nuts and seeds are high in healthy fats, protein, and fiber, providing essential nutrients like vitamin E and magnesium. They can be consumed as snacks or added to meals for extra nutrition. Nuts and seeds contain antioxidants that protect cells from damage and reduce inflammation. They also support heart health by improving cholesterol levels.",
  "Brown rice is a whole grain rich in complex carbohydrates, fiber, and essential minerals like magnesium and selenium, supporting sustained energy and fullness. It contains lignans and phytic acid, which have antioxidant and anti-inflammatory properties. Brown rice is also beneficial for digestive health and helps regulate bowel movements.",
  "Avocado is rich in monounsaturated fats, supporting heart health and hormone production. It also provides fiber, potassium, and vitamins promoting recovery and overall health. The healthy fats in avocado enhance the absorption of fat-soluble vitamins like A, D, E, and K. Avocado also contains lutein, which is beneficial for eye health.",
  "Cottage cheese is high in casein protein, which digests slowly, providing a steady supply of amino acids to the muscles. It is also a good source of calcium, which is crucial for bone health. Cottage cheese can help in weight management by promoting satiety and reducing appetite. It is also rich in phosphorus, which works with calcium to maintain strong bones and teeth.",
  "Beans and lentils are plant-based protein sources high in fiber and essential vitamins and minerals like iron and folate, supporting muscle growth and recovery. They help regulate blood sugar levels and support heart health by lowering cholesterol. Beans and lentils are also rich in antioxidants, which protect against chronic diseases and support a healthy immune system.",
  "A variety of fruits and vegetables provide essential vitamins, minerals, and antioxidants, supporting overall health, immune function, and recovery. They also add fiber to the diet, aiding in digestion and nutrient absorption. Incorporating a colorful array of fruits and vegetables ensures you get a broad spectrum of nutrients, promoting optimal health and reducing the risk of chronic diseases.",
  "Whole grain bread is a good source of complex carbohydrates and fiber, maintaining steady energy levels and supporting digestion. It also provides B vitamins and iron, essential for energy production and oxygen transport in the body. Whole grain bread helps in maintaining a healthy weight by promoting fullness and reducing hunger. It also supports heart health by lowering cholesterol levels.",
  "Chia seeds are rich in omega-3 fatty acids, protein, and fiber, supporting heart health, digestion, and sustained energy levels. They are also high in antioxidants, which protect cells from damage and reduce inflammation. Chia seeds can help in weight management by promoting satiety and reducing appetite. They are also a good source of calcium, magnesium, and phosphorus, supporting bone health."
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
