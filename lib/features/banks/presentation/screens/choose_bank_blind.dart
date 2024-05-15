import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/banks/presentation/screens/choose_service.dart';
import 'package:blindbnking/features/banks/presentation/screens/get_bank_details.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseBankBlind extends StatelessWidget {
  final TextToSpeech textToSpeech = TextToSpeech();
  @override
  Widget build(BuildContext context) {
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
          'Choose Your Bank',
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
                BankNamesBlind(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'BOC',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseService(bankName: 'BOC',),),
                    );
                    // Convert text to speech
                    textToSpeech.speak('Bank Of Ceyloan');
                    // Stop speech
                    textToSpeech.stop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BankNamesBlind(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'NSB',
                  onPressed: () {
                      // Convert text to speech
                    textToSpeech.speak('Nation Trust Bank');
                    // Stop speech
                    textToSpeech.stop();
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseService(bankName: 'NSB')),
                );
                    
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BankNamesBlind(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Peoples Bank',
                  onPressed: () {
                    // Convert text to speech
                    textToSpeech.speak('Peoples Bank');
                    // Stop speech
                    textToSpeech.stop();

                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseService(bankName: 'Peoples Bank')),
            );
                    
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BankNamesBlind(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Sampath Bank',
                  onPressed: () {
                    // Convert text to speech
                    textToSpeech.speak('Sampath Bank');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseService(bankName: 'Sampath Bank')),
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

class BankNamesBlind extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPressed;
  final double iconSize;
  final double textSize;

  const BankNamesBlind({
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
        padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 24.0),
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
