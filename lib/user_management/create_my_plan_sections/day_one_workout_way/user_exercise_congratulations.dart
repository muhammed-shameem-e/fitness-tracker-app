import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/home_page.dart';

class UserCongratulations extends StatefulWidget {
  const UserCongratulations({super.key});
  @override
  State<UserCongratulations> createState() => _UserCongratulationssState();
}

class _UserCongratulationssState extends State<UserCongratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 3, 63),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Congratulations...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipRRect(
              child: Image.asset(
                'assets/congratulations.gif',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Great job today! Every drop of sweat brings you closer to your goal. Keep pushing, you're stronger than you think!",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
           ElevatedButton(onPressed: (){
               Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(data: UsersData(name: '', age: ''))),
          (Route<dynamic> route) => route.isFirst,
        );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
              side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                width: 6,
                color: Color.fromARGB(255, 132, 172, 134)
              )),
              minimumSize: WidgetStateProperty.all<Size>( const Size(300, 70)),
            )
            , child: const Text('Continue',style: TextStyle(fontSize: 25,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
