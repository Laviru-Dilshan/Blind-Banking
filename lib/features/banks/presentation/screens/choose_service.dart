import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/bank_services/presentation/screens/cash_deposit_screen.dart';
import 'package:blindbnking/features/banks/presentation/screens/choose_bank_screen.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseService extends StatelessWidget {

  final String bankName;
  final TextToSpeech textToSpeech = TextToSpeech();

  ChooseService({required this.bankName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
             // Convert text to speech
            textToSpeech.speak('Back To Choose Bank Screen');
            // Stop speech
            textToSpeech.stop();
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseBank()),
            );
          },
        ),
        title: Text(
          bankName,
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
              size: 130.0, 
              color: Colors.blue, 
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ServiceName(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Cash Withdraw',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Cash Withdraw');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashDepositScreen(selectedService: 'Cash Withdraw'),
                    ),
                  );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ServiceName(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Cash Deposit',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Cash Deposit');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashDepositScreen(selectedService: 'Cash Deposit'),
                    ),
                  );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ServiceName(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Loan Service',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Loan Service');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashDepositScreen(selectedService: 'Loan Service'),
                    ),
                  );
                  },
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ServiceName(
                  icon: FontAwesomeIcons.bitcoin,
                  name: 'Mortgage Service',
                  onPressed: () {
                     // Convert text to speech
                    textToSpeech.speak('Mortgage Service');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashDepositScreen(selectedService: 'Mortgage Service'),
                    ),
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

class ServiceName extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPressed;
  final double iconSize;
  final double textSize;

  const ServiceName({
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
