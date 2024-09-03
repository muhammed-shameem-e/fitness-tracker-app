import 'package:flutter/material.dart';

class Periodization extends StatefulWidget {
  const Periodization({super.key,required this.heading});
  final String heading;

  @override
  State<Periodization> createState() => _PeriodizationState();
}

class _PeriodizationState extends State<Periodization> {

final _foodNames = [
  'Lean Proteins','Fish','Eggs','Legumes','Nuts and Seeds','Whole Grains','Fruits','Vegetables','Avocados','Dairy or Dairy Alternatives',
  'Hydrating Foods'
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
    'assets/hydrationfoods.jfif'
  ];

final _foodExplanations= [
  'Lean proteins such as chicken breast, turkey, and lean cuts of beef are crucial throughout all phases of periodization. They provide high-quality protein for muscle repair, growth, and recovery, ensuring that your muscles recover effectively from intense training sessions and are prepared for the next phase.',
  
  'Fatty fish like salmon, mackerel, and sardines are excellent sources of protein and omega-3 fatty acids. Omega-3s help reduce inflammation and support recovery, making them beneficial for both high-intensity training phases and recovery periods. Fish also provides essential vitamins and minerals that support overall health and performance.',
  
  'Whole eggs offer a complete source of protein with all essential amino acids needed for muscle synthesis and repair. They also provide important nutrients like vitamin D, which supports bone health and recovery, and B vitamins, which are crucial for energy metabolism.',
  
  'Legumes such as lentils, chickpeas, and beans are great sources of plant-based protein and fiber. The fiber aids digestion and helps regulate blood sugar levels, while the protein supports muscle recovery and endurance during training phases.',
  
  'Nuts and seeds, including almonds, walnuts, chia seeds, and flaxseeds, offer healthy fats, protein, and essential nutrients. They support muscle repair, provide sustained energy, and contribute to overall recovery and hormonal balance.',
  
  'Whole grains like quinoa, brown rice, and oats provide complex carbohydrates that fuel high-intensity workouts and help replenish glycogen stores. They also offer fiber, which supports digestive health and maintains stable energy levels.',
  
  'Fruits such as berries, bananas, and oranges are rich in vitamins, antioxidants, and natural sugars. They help replenish glycogen stores, support immune function, and aid in recovery by reducing oxidative stress and inflammation.',
  
  'Vegetables like spinach, kale, and sweet potatoes provide essential vitamins and minerals, along with antioxidants that support recovery and overall health. They help reduce inflammation and support muscle function and performance.',
  
  'Avocados are rich in healthy fats, fiber, and potassium. They support hormone production, improve nutrient absorption, and help with muscle function and recovery. The healthy fats also contribute to overall energy levels.',
  
  'Greek yogurt, milk, and plant-based alternatives like almond milk provide protein and calcium, which are important for muscle repair and bone health. They also offer additional nutrients that support overall recovery and performance.',
  
  'Hydrating foods like watermelon, cucumber, and coconut water help maintain electrolyte balance and hydration levels, which are crucial for optimal performance and recovery during all phases of periodization.'
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
