import 'package:blindbnking/config/app_values.dart';
import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextToSpeech textToSpeech = TextToSpeech();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
                    // Convert text to speech
                    textToSpeech.speak('Back To Home Screen');
                    // Stop speech
                    textToSpeech.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ContactMethod(
                icon: FontAwesomeIcons.facebook,
                name: 'Blind Banking',
                onPressed: () {
                  // Share.share(
                  //           'Join With Blind Banking And Be Smart');
                },
              ),
              const SizedBox(height: 25.0),
              ContactMethod(
                icon: FontAwesomeIcons.instagram,
                name: '@Blind Banking',
                onPressed: () {
                  
                },
              ),
              const SizedBox(height: 25.0),
              ContactMethod(
                icon: FontAwesomeIcons.whatsapp,
                name: '(+94)433 21 7890',
                onPressed: () {
                  // Share.share(
                  //           'Join With Blind Banking And Be Smart');
                },
              ),
              const SizedBox(height: 25.0),
              ContactMethod(
                icon: Icons.phone,
                name: '(+94)433 21 7890',
                onPressed: () {
                  // Share.share(
                  //           'Join With Blind Banking And Be Smart');
                },
              ),
              const SizedBox(height: 25.0),
              ContactMethod(
                icon: Icons.mail,
                name: 'blindbanking@gmail.com',
                onPressed: () {
                  // Share.share(
                  //           'Join With Blind Banking And Be Smart');
                },
              ),
            ],
          ),
        ),
      ),
          );
  }
}

class ContactMethod extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPressed;
  final double iconSize;
  final double textSize;

  const ContactMethod({
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
          const SizedBox(width: AppValues.padding), // Add spacing between icon and text
          Text(
            name,
            style: TextStyle(
              fontSize: textSize,
            ),
          ),
        ],
      ),
    );
  }
}


