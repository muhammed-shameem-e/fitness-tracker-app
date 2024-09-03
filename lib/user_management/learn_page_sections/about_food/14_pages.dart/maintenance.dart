import 'package:flutter/material.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({super.key,required this.heading});
  final String heading;

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  final _foodsForMaintenance = [
  'Chicken Breast','Turkey','Eggs','Greek Yogurt','Lean Beef','Fish'
];
  final _foodExplanations = [
  'Chicken breast is a top choice for those looking to maintain a healthy body weight and muscle mass. It’s high in lean protein, which is essential for muscle repair and growth. Unlike other cuts of chicken, the breast has minimal fat, making it ideal for those who want to stay lean. Additionally, chicken breast provides vital nutrients like niacin (vitamin B3) and vitamin B6, which support energy metabolism and overall health. It’s versatile, easy to cook, and can be included in a variety of dishes.',
  
  'Turkey, particularly the breast meat, is another excellent source of lean protein. It helps in building and maintaining muscle mass while being low in fat, which helps in managing calorie intake. Turkey is also rich in essential nutrients such as iron, which is crucial for carrying oxygen to your cells, and zinc, which supports immune function. Its mild flavor makes it a great addition to many meals, from sandwiches to salads.',
  
  'Eggs are a nutrient-dense food packed with high-quality protein. They contain all nine essential amino acids needed for muscle maintenance and repair. Each egg provides a significant amount of vitamins and minerals, including vitamin B12, which is vital for red blood cell production, and choline, which supports brain function. The yolk contains healthy fats and additional vitamins like vitamin D, which supports bone health. Eggs are highly versatile and can be cooked in many different ways, making them a convenient option for maintaining overall health.',
  
  'Greek yogurt is rich in protein, which supports muscle health and helps keep you full longer. It also contains probiotics, which are beneficial bacteria that promote a healthy digestive system by improving gut health. Greek yogurt is also a good source of calcium, which is essential for maintaining strong bones and teeth. It’s thicker and creamier than regular yogurt due to the straining process, which also reduces the sugar content, making it a healthier choice for those managing their weight.',
  
  'Lean beef is a valuable source of protein that supports muscle growth and repair. It’s also rich in iron, which helps transport oxygen throughout the body and supports energy levels. Additionally, lean beef provides B vitamins, particularly B12, which is important for maintaining nerve function and red blood cell production. Choosing lean cuts, such as sirloin or tenderloin, ensures that you get the benefits of beef without excessive fat and calories. It’s a flavorful addition to a balanced diet and can be included in various dishes.',
  
  'Fish like salmon and tuna are excellent sources of high-quality protein and healthy fats. Salmon is particularly known for its omega-3 fatty acids, which are beneficial for heart health, reducing inflammation, and supporting brain function. Tuna also provides these healthy fats along with important nutrients like selenium, which acts as an antioxidant to protect your cells. Both types of fish are low in saturated fat and offer essential vitamins and minerals, making them an important part of a balanced diet for maintaining overall health.',
];
  final _foodPhotos = [
    'assets/chickenbreast.jfif',
    'assets/turkey.jfif',
    'assets/eggs.jfif',
    'assets/yogurt.jfif',
    'assets/leanbeef.jfif',
    'assets/fish.jfif',
  ];

  int _currentIndex = 0;
  bool _isForward = true;

  void _previousFood() {
    setState(() {
      _isForward = false;
      _currentIndex = (_currentIndex - 1 + _foodsForMaintenance.length) % _foodsForMaintenance.length;
    });
  }

  void _nextFood() {
    setState(() {
      _isForward = true;
      _currentIndex = (_currentIndex + 1) % _foodsForMaintenance.length;
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
                          _foodsForMaintenance[_currentIndex],
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
