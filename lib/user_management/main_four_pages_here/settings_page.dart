import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/admin_home_page.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fullbody_workout/main.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/about_us.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/dart_and_white.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/profile_things/profile_page.dart';
import 'package:fullbody_workout/user_management/settings_funtionalities/terms_and_conditions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.data, this.toggleTheme});
  final UsersData data; // User data
  final Function(bool)? toggleTheme; // Theme toggle callback

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedStar = -1; // Rating star selected
  final _icons = [Icons.person, Icons.color_lens, Icons.description, Icons.restart_alt]; // Icons for settings
  final _titles = ['Profile', 'Theme', 'Terms & Conditions', 'Restart Progress']; // Titles for settings options

  final icon = [Icons.share, Icons.rate_review, Icons.feedback, Icons.info]; // Icons for support options
  final title = ['Share App', 'Rate Us', 'Feedback', 'About Us']; // Titles for support options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // General Settings Header
              Text(
                'General',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // General Settings Options
              Column(
                children: List.generate(
                  _titles.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Handle settings option tap
                          if (index == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const ProfilePage()),
                            );
                          } else if (index == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ThemePage(toggleTheme: widget.toggleTheme)),
                            );
                          } else if (index == 2) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                            );
                          } else if (index == 3) {
                            restartAllProgress();
                          }
                        },
                        child: ListTile(
                          leading: Icon(_icons[index], color: Colors.blue),
                          title: Text(
                            _titles[index],
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 211, 211, 211),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Support Us Header
              Text(
                'Support Us',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Support Us Options
              Column(
                children: List.generate(
                  title.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          // Handle support option tap
                          if (index == 0) {
                            Share.share('Check out this amazing app: https://example.com/app');
                          } else if (index == 1) {
                            rateUs();
                          } else if (index == 2) {
                            sendFeedback();
                          } else if (index == 3) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AboutUs()),
                            );
                          }
                        },
                        child: ListTile(
                          leading: Icon(icon[index], color: Colors.blue),
                          title: Text(
                            title[index],
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 211, 211, 211),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Log Out Button
              GestureDetector(
                onTap: () {
                  logOutAlert(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Go to Admin Side',
                      style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show log out confirmation dialog
  Future<void> logOutAlert(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: const Text('Are you sure you want to go Admin Side'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool(SAVE_ADMIN_VALUE, true);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AdminHomePage()),
                  (Route<dynamic> route) => route.isFirst,
                );
              },
              child: const Text('YES', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  // Show restart all progress confirmation dialog
  void restartAllProgress() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restart All Progresses'),
          content: const Text('This will remove your day-by-day exercise records'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'NO',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            TextButton(
              onPressed: () async {
                final upperbodyBox = await Hive.openBox('upperBodyWorkoutBox');
                await upperbodyBox.put('lastCompletedUpperBodyDay', 0);
                final absBox = await Hive.openBox('absWorkoutBox');
                await absBox.put('lastCompletedAbsDay', 0);
                final legBox = await Hive.openBox('legWorkoutBox');
                await legBox.put('lastCompletedLegDay', 0);
                final otherBox = await Hive.openBox('newWorkoutBox');
                await otherBox.put('lastCompletednewDay', 0);
                Navigator.of(context).pop();
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show rating dialog
  void rateUs() {
    _selectedStar = -1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            String currentImage = '';
            String currentText = '';

            if (_selectedStar == -1) {
              currentImage = 'assets/blushphoto.png';
              currentText = "Your feedback helps us grow! We'd love it if you could take a moment to rate your experience.";
            } else if (2 >= _selectedStar) {
              currentImage = 'assets/sadphoto.png';
              currentText = "Uh-oh! Something went wrong? We’d love to hear your feedback to make things right.";
            } else if (_selectedStar == 3) {
              currentImage = 'assets/smilephoto.png';
              currentText = "You're awesome! Thanks for sharing your feedback with us!";
            } else if (_selectedStar == 4) {
              currentImage = 'assets/happyphoto.png';
              currentText = "You're awesome! Thanks for sharing your feedback with us!";
            }

            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.asset(currentImage, height: 100, width: 100),
                    ),
                    Text(
                      currentText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedStar = index;
                                  });
                                },
                                child: index <= _selectedStar
                                    ? const Icon(Icons.star, size: 38, color: Colors.green)
                                    : const Icon(Icons.star_border, color: Colors.green, size: 38),
                              ),
                              if (index != 4) const SizedBox(width: 10),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                        minimumSize: WidgetStateProperty.all<Size>(const Size(300, 60)),
                      ),
                      child: const Text('Rate us', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Send feedback via email
  void sendFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'shameemokv@gmail.com',
      query: 'subject=Feedback&body=',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client');
    }
  }
}
