import 'package:flutter/material.dart';

class FunctionalTraining extends StatefulWidget {
  const FunctionalTraining({super.key,required this.heading});
  final String heading;

  @override
  State<FunctionalTraining> createState() => _FunctionalTrainingState();
}

class _FunctionalTrainingState extends State<FunctionalTraining> {

final _foodNames = [
  'Lean Meats','Fish','Eggs','Legumes','Nuts and Seeds','Whole Grains','Fruits','Vegetables','Avocados','Dairy or Dairy Alternatives'
];

final _foodPhotos = [
    'assets/leanmeats.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
    'assets/legumes.jfif',
    'assets/needsandnuds.jfif',
    'assets/wholegrainbread.jfif',
    'assets/fruitsandvegitables.jfif',
    'assets/fruitsandvegitables.jfif',
    'assets/avocado.jfif',
    'assets/dairy.jfif',
  ];

final _foodExplanations=[
  'Lean meats such as chicken breast, turkey, and lean cuts of beef are excellent sources of high-quality protein, essential for muscle repair and growth. They provide necessary amino acids for functional movements and overall strength, helping you recover faster and perform better in training sessions.',
  
  'Fatty fish like salmon, mackerel, and trout are rich in protein and omega-3 fatty acids, which help reduce inflammation and improve joint health. These properties are crucial for functional training that involves complex, multi-joint exercises. Fish also offers essential vitamins and minerals that support overall health and recovery.',
  
  'Whole eggs are a complete protein source, containing all essential amino acids necessary for muscle growth and repair. They are also rich in vitamin D and B vitamins, which support energy metabolism, muscle function, and overall performance. The healthy fats in egg yolks contribute to hormone production and recovery.',
  
  'Legumes such as lentils, chickpeas, and beans provide plant-based protein and are rich in fiber. The fiber helps with digestion and blood sugar regulation, while the protein supports muscle repair and endurance during functional training. They also offer essential minerals like iron and magnesium that are important for energy production.',
  
  'Nuts and seeds, including almonds, walnuts, chia seeds, and flaxseeds, offer a combination of protein, healthy fats, and essential nutrients. These foods support muscle growth and repair, while healthy fats improve joint health and overall recovery. They also provide energy and help in sustaining long training sessions.',
  
  'Whole grains like quinoa, brown rice, and oats provide complex carbohydrates that release energy slowly, helping to sustain energy levels during functional training. They are also high in fiber, which aids in digestion and maintains stable blood sugar levels, supporting overall endurance and performance.',
  
  'Fruits such as berries, bananas, and apples are packed with vitamins, minerals, and antioxidants. They provide quick energy and help replenish glycogen stores used during intense training. Antioxidants from fruits support recovery by reducing oxidative stress and inflammation caused by strenuous exercise.',
  
  'Vegetables like spinach, kale, and bell peppers are rich in essential nutrients and antioxidants that support muscle function and overall health. They help in reducing oxidative stress and inflammation, promoting quicker recovery and better performance during functional training sessions.',
  
  'Avocados are a great source of healthy monounsaturated fats, fiber, and potassium. The healthy fats support hormone production and nutrient absorption, while potassium helps with muscle function and prevents cramping. Avocados also aid in maintaining overall joint health and recovery.',
  
  'Dairy products like Greek yogurt and milk provide high-quality protein and calcium. Protein supports muscle repair and growth, while calcium is essential for bone health, which is crucial for maintaining strength and performance. Plant-based alternatives like almond or soy milk also offer similar benefits and are suitable for those avoiding dairy.'
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
