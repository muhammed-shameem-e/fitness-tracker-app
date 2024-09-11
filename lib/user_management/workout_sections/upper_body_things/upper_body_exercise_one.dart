// upper_body_exercise_one.dart

import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/short_codelist/upperbody_exercises_lists.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upper_body_rest_time.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upperbody_congratulations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpperBodyExerciseOne extends StatefulWidget {
  const UpperBodyExerciseOne({
    super.key,
    required this.index,
    required this.completedDay,
    required this.listLength,
  });

  final int index;
  final int completedDay;
  final int listLength;

  @override
  State<UpperBodyExerciseOne> createState() => _UpperBodyExerciseOneState();
}

class _UpperBodyExerciseOneState extends State<UpperBodyExerciseOne> {
  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isThumbDownPressed = prefs.getBool('isThumbDownPressed${widget.index}') ?? false;
      isThumbUpPressed = prefs.getBool('isThumbUpPressed${widget.index}') ?? false;
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isThumbDownPressed${widget.index}', isThumbDownPressed);
    await prefs.setBool('isThumbUpPressed${widget.index}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildExerciseGif(),
            _buildLikeDislikeButtons(),
            const SizedBox(height: 20),
            _buildExerciseInfo(),
            const SizedBox(height: 40),
            _buildNavigationButtons(context, isDarkMode),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            UpperBodyExerciseData.exerciseNames[widget.index],
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '${widget.index + 1}/${widget.listLength}',
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () => _showExitAlert(context),
        ),
      ],
    );
  }

  Widget _buildExerciseGif() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        child: Image.asset(UpperBodyExerciseData.upperBodyGifs[widget.index]),
      ),
    );
  }

  Widget _buildLikeDislikeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              isThumbDownPressed = !isThumbDownPressed;
              isThumbUpPressed = false;
              savePreferences();
            });
          },
          icon: Icon(
            Icons.thumb_down,
            color: isThumbDownPressed ? Colors.red : Theme.of(context).iconTheme.color,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isThumbUpPressed = !isThumbUpPressed;
              isThumbDownPressed = false;
              savePreferences();
            });
          },
          icon: Icon(
            Icons.thumb_up,
            color: isThumbUpPressed ? Colors.green : Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseInfo() {
    return Column(
      children: [
        const Text(
          'Benefit of this exercise',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Text(
          UpperBodyExerciseData.exerciseBenefits[widget.index],
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBackButton(),
        _buildRepsButton(isDarkMode),
        _buildForwardButton(context),
      ],
    );
  }

  ElevatedButton _buildBackButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(20)),
      onPressed: widget.index == 0 ? null : () => _navigateToPreviousExercise(),
      child: const Icon(Icons.arrow_back, size: 40),
    );
  }

  ElevatedButton _buildRepsButton(bool isDarkMode) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: isDarkMode ? Colors.grey[800] : const Color(0xFFFFF7EB),
      ),
      onPressed: () {},
      child: Text('${UpperBodyExerciseData.reps[widget.index]}', style: const TextStyle(fontSize: 20)),
    );
  }

  ElevatedButton _buildForwardButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(20)),
      onPressed: () {
        if (widget.index == UpperBodyExerciseData.upperBodyGifs.length - 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UpperbodyCongratulation(completedDay: widget.completedDay),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpperBodyRestTime(
              completedDay: widget.completedDay,
              index: widget.index + 1,
            ),
          ));
        }
      },
      child: const Icon(Icons.arrow_forward, size: 40),
    );
  }

  void _navigateToPreviousExercise() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UpperBodyExerciseOne(
        index: widget.index - 1,
        completedDay: widget.completedDay,
        listLength: widget.listLength,
      ),
    ));
  }

  void _showExitAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to skip today\'s workout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const UpperBody30Days(),
              )),
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
