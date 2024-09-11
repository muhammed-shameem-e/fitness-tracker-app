import 'package:flutter/material.dart';

class RestDayPage extends StatefulWidget {
  // Constructor for RestDayPage. Requires an onComplete callback.
  const RestDayPage({super.key, required this.onComplete});
  final VoidCallback onComplete;

  @override
  _RestDayPageState createState() => _RestDayPageState();
}

class _RestDayPageState extends State<RestDayPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController and Animation.
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is removed from the widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Animated container in the center of the page.
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 6,
                      color: const Color.fromARGB(255, 90, 169, 235),
                    ),
                  ),
                  child: Center(
                    child: ScaleTransition(
                      scale: _animation,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.bolt,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Text and button at the bottom of the page.
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    // Encouraging text for the user to take a rest day.
                    const Text(
                      "Great job finishing your workout streak! It's time for a rest day. Use this day to let your muscles recover and come back even stronger. Enjoy some relaxation, and get ready to crush your next workout session!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Button to acknowledge the rest day and return to the previous screen.
                    ElevatedButton(
                      onPressed: () {
                        // Call the onComplete callback and pop the current page off the navigation stack.
                        widget.onComplete();
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                        minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
