import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/about/presentation/screens/about_us_screen.dart';
import 'package:blindbnking/features/banks/presentation/screens/choose_bank_blind.dart';
import 'package:blindbnking/features/banks/presentation/screens/choose_bank_screen.dart';
import 'package:blindbnking/features/banks/presentation/screens/select_bank_screen.dart';
import 'package:blindbnking/features/contact_us/presenatation/screens/contact_us_screen.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final TextToSpeech textToSpeech = TextToSpeech();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(
              Icons.account_balance,
              size: 130.0, // Adjust the size as needed
              color: Colors.blue, // Optional: Change the color
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeMenu(
                  icon: FontAwesomeIcons.earDeaf,
                  name: 'Dumb / Deaf Users',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Dumb / Deaf Users');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseBank()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HomeMenu(
                  icon: FontAwesomeIcons.eyeLowVision,
                  name: 'Blind Users',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Blind Users');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseBankBlind()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeMenu(
                  icon: FontAwesomeIcons.plus,
                  name: 'Add Bank',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Add Bank');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectBank()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HomeMenu(
                  icon: Icons.contact_support_sharp,
                  name: 'Contact Us',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Contact Us');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeMenu(
                  icon: FontAwesomeIcons.info,
                  name: 'About Us',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('About Us');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HomeMenu(
                  icon: Icons.logout,
                  name: 'Log Out',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Log Out');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPressed;
  final double iconSize;
  final double textSize;

  const HomeMenu({
    Key? key,
    required this.icon,
    required this.name,
    required this.onPressed,
    this.iconSize = 30.0,
    this.textSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize,
          ),
          const SizedBox(width: 20.0), // Add spacing between icon and text
          Text(
            name,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
