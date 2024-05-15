import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final TextToSpeech textToSpeech = TextToSpeech();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Convert text to speech
            textToSpeech.speak('Back To Home Screen');
            // Stop speech
            textToSpeech.stop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Set your primary color here
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our App!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Adjust color to match your theme
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our banking system is designed with inclusivity in mind, catering to users who are blind, deaf, or mute while remaining user-friendly for all. Key features include voice commands and fingerprint authentication for seamless and secure access. Our goal is to ensure that every user, regardless of ability, can confidently and independently manage their finances with ease',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'My Mission:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Adjust color to match your theme
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our mission is to create a helpful banking app that supports users with diverse needs, simplifying their banking experience. We aim to provide accessible solutions for all users, ensuring everyone can manage their finances with ease and confidence',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                'About Me:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Adjust color to match your theme
                ),
              ),
              SizedBox(height: 10.0),
              // Display personal information
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AboutMeDetail(label: 'My Name', value: 'Hasitha Gamlath'),
                  AboutMeDetail(
                      label: 'Email', value: 'hasithagamlath2002@gmail.com'),
                  AboutMeDetail(label: 'Contact No:', value: '+94 74 238 9226'),
                  AboutMeDetail(label: 'My Role', value: 'Developer'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutMeDetail extends StatelessWidget {
  final String label;
  final String value;

  AboutMeDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Adjust color to match your theme
        ),
      ),
      subtitle: Text(value),
    );
  }
}
