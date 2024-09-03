import 'package:flutter/material.dart';

class HighIntensityIntervalTraining extends StatefulWidget {
  const HighIntensityIntervalTraining({super.key,required this.heading});
  final String heading;

  @override
  State<HighIntensityIntervalTraining> createState() => _HighIntensityIntervalTrainingState();
}

class _HighIntensityIntervalTrainingState extends State<HighIntensityIntervalTraining> {

final _foodNames =  [
  'Lean Proteins','Fish','Eggs','Sweet Potatoes','Greek Yogurt','Berries','Quinoa','Nuts and Seeds','Avocados','Whole Grains',
  'Hydrating Foods'
];

final _foodPhotos = [
    'assets/leanmeats.jfif',
    'assets/fish.jfif',
    'assets/eggs.jfif',
    'assets/sweetpotatoes.jfif',
    'assets/yogurt.jfif',
    'assets/berries.jfif',
    'assets/quinoa.jfif',
    'assets/needsandnuds.jfif',
    'assets/avocado.jfif',
    'assets/qholegrainbread.jfif',
    'assets/hydrationfoods.jfif'
  ];

final _foodExplanations=[
  'Lean proteins such as chicken breast, turkey, and lean cuts of beef are essential for muscle repair and recovery after intense HIIT sessions. They provide high-quality protein that supports muscle repair and growth, helping you recover quickly and be ready for your next workout.',
  
  'Fatty fish like salmon, mackerel, and sardines are rich in protein and omega-3 fatty acids. Omega-3s help reduce inflammation, support muscle recovery, and improve overall joint health, which is vital for high-intensity workouts.',
  
  'Whole eggs offer a complete source of protein with all essential amino acids needed for muscle repair and growth. They also contain vitamins and minerals like vitamin D and B vitamins that support energy metabolism and overall recovery.',
  
  'Sweet potatoes are an excellent source of complex carbohydrates that provide sustained energy for intense workouts. They also offer vitamins, minerals, and antioxidants that support overall health and recovery.',
  
  'Greek yogurt provides a high amount of protein and probiotics, which aid in digestion and muscle recovery. It also contains carbohydrates to help replenish glycogen stores after intense exercise.',
  
  'Berries such as blueberries, strawberries, and raspberries are rich in antioxidants and vitamins. They help reduce oxidative stress and inflammation, support recovery, and provide quick energy through natural sugars.',
  
  'Quinoa is a complete protein and a good source of complex carbohydrates. It provides sustained energy and helps replenish glycogen stores while offering essential amino acids needed for muscle repair.',
  
  'Nuts and seeds like almonds, walnuts, chia seeds, and flaxseeds are high in healthy fats, protein, and essential nutrients. They help support muscle repair, provide sustained energy, and aid in recovery.',
  
  'Avocados are rich in healthy fats, potassium, and fiber. They support overall recovery, improve nutrient absorption, and help maintain electrolyte balance, which is crucial after intense HIIT sessions.',
  
  'Whole grains such as brown rice, oats, and barley provide complex carbohydrates for sustained energy. They help replenish glycogen stores and support overall energy levels and recovery.',
  
  'Hydrating foods like watermelon, cucumber, and coconut water help maintain hydration and electrolyte balance. They are essential for optimal performance and recovery during and after high-intensity workouts.'
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
