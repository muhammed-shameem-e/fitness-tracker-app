import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/profile_things/history_of_bmi.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int length = categoriesList.value.length;
  double upperBodyProgress = 0.0;
  double absProgress = 0.0;
  double legProgress = 0.0;
  TextEditingController userHeight = TextEditingController();
  TextEditingController userWeight = TextEditingController();
  String bmi = '';
  UsersData? user;
  
  Future<void> _saveBmi(String bmiResult) async {
    final box = await Hive.openBox('saveBmi_db');
    final dateTime = DateTime.now();
    await box.add({'bmi': bmiResult, 'date': dateTime.toIso8601String()});
  }

  void _displayBmiResult() {
    setState(() {
      bmi = _calculationOfBmi();
      if (bmi.isNotEmpty) {
        _saveBmi(bmi);
      }
    });
  }
  
  Future<void> _loadUpperBodyProgress() async {
    final box = await Hive.openBox('upperBodyWorkoutBox');
    final lastCompletedDay = box.get('lastCompletedUpperBodyDay', defaultValue: 0);
    setState(() {
      upperBodyProgress = lastCompletedDay / 30;
    });
  }

  Future<void> _loadAbsProgress() async {
    final box = await Hive.openBox('absWorkoutBox');
    final lastCompletedDay = box.get('lastCompletedAbsDay', defaultValue: 0);
    setState(() {
      absProgress = lastCompletedDay / 30;
    });
  }

  Future<void> _loadLegProgress() async {
    final box = await Hive.openBox('legWorkoutBox');
    final lastCompletedday = box.get('lastCompletedLegDay', defaultValue: 0);
    setState(() {
      legProgress = lastCompletedday / 30;
    });
  }
  
  @override
  void initState() {
    super.initState();
    fetchUserData();
    _loadAbsProgress();
    _loadLegProgress();
    _loadUpperBodyProgress();
  }

  Future<void> fetchUserData() async {
    final fetchedUser = await fetchUserDetails();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/profilephoto.jfif'), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: 445,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user?.name ?? 'Loading...',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final value = await alertEditUserDetails(context, user);
                                    if (value != null) {
                                      fetchUserData();
                                    }
                                  },
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              user?.age ?? 'Loading...',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Upperbody',
                              style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${30 - (upperBodyProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white)),
                                Text('${(upperBodyProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            LinearProgressIndicator(value: upperBodyProgress, color: Colors.green),
                            const SizedBox(height: 10),
                            const Text(
                              'Abs',
                              style: TextStyle(color: Colors.green, fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${30 - (absProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white)),
                                Text('${(absProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            LinearProgressIndicator(value: absProgress, color: Colors.green),
                            const SizedBox(height: 10),
                            const Text(
                              'Leg',
                              style: TextStyle(color: Colors.green, fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${30 - (legProgress * 30).toInt()} days left', style: const TextStyle(color: Colors.white)),
                                Text('${(legProgress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            LinearProgressIndicator(value: legProgress, color: Colors.green),
                            Center(
                              child: Opacity(
                                opacity: 0.6,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Image.asset('assets/stylephoto.png',fit: BoxFit.contain,)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Calculation of BMI',
                                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryOfBmi()));
                                  },
                                  icon: const Icon(Icons.list, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 150,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.withOpacity(0.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: userHeight,
                                          style: const TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: 'Height(eg:1.70)',
                                            hintStyle: TextStyle(color: Color.fromARGB(255, 243, 242, 242)),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: userWeight,
                                          style: const TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: 'Weight(kg)',
                                            hintStyle: TextStyle(color: Color.fromARGB(255, 243, 242, 242)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  onPressed: () {
                                    _displayBmiResult();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<Color>(Colors.orange.withOpacity(0.3)),
                                    minimumSize: WidgetStateProperty.all<Size>(const Size(100,150)),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Image.asset('assets/calculater.png', height: 50, width: 50,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            bmi.isEmpty
                                ? const Text('Please enter valid height and weight.', style: TextStyle(color: Colors.white))
                                : Text(bmi, style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _calculationOfBmi() {
    final height = double.tryParse(userHeight.text);
    final weight = double.tryParse(userWeight.text);
    if (height != null && weight != null) {
      final bmiResult = weight / (height * height);
      if (bmiResult < 18.5) {
        return 'Your body BMI is Underweight (${bmiResult.toStringAsFixed(0)})';
      } else if (bmiResult >= 18.5 && bmiResult < 24.9) {
        return 'Your body BMI is Normal weight (${bmiResult.toStringAsFixed(0)})';
      } else if (bmiResult >= 25 && bmiResult < 29.9) {
        return 'Your body BMI is Overweight (${bmiResult.toStringAsFixed(0)})';
      } else if (bmiResult >= 30) {
        return 'Your body BMI is Obesity (${bmiResult.toStringAsFixed(0)})';
      }
    }
    return '';
  }
  
  Future<int?> alertEditUserDetails(BuildContext context, UsersData? detail) async {
    final userNewName = TextEditingController(text: detail?.name ?? '');
    final userNewAge = TextEditingController(text: detail?.age.toString() ?? '');
    return showDialog<int?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit your name & age'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: userNewName,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: userNewAge,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (userNewName.text.isNotEmpty && userNewAge.text.isNotEmpty) {
                      final newData = UsersData(
                        name: userNewName.text,
                        age: userNewAge.text,
                        id: user!.id?? 2,
                      );
                      await updateUserData(newData);
                      Navigator.of(context).pop(1);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(const Size(100, 50)),
                  ),
                  child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
