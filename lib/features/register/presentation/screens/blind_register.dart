import 'package:blindbnking/core/service/secureStorage/secure_storage.dart';
import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/register/domain/service/auth_service.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class BlindRegisterScreen extends StatefulWidget {
  @override
  _BlindRegisterScreenState createState() => _BlindRegisterScreenState();
}

class _BlindRegisterScreenState extends State<BlindRegisterScreen> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextToSpeech textToSpeech = TextToSpeech();

  TextEditingController _emailController = TextEditingController();
  String _typedEmail = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Text(
              'Enter your email address:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                suffixText: '@gmail.com',
              ),
            ),

            const SizedBox(height: 50.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListingButtons(
                      icon: Icons.mic,
                      name: 'Start Listening',
                      onPressed: () {
                        _startListeningForEmail();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListingButtons(
                      icon: Icons.stop,
                      name: 'Stop Listening',
                      onPressed: () {
                        _confirmEmail();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startListeningForEmail() async {
    if (await _speechToText.initialize()) {
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _typedEmail = result.recognizedWords;
            _emailController.text = _typedEmail;
          });
        },  
      );
    } else {
      print('Speech recognition not available');
    }
  }

  void _confirmEmail() {
  if (!_speechToText.isAvailable) {
    print('Speech recognition not available');
    return;
  }

  _flutterTts.speak('You entered $_typedEmail @gmail.com Is this correct? Say ok to confirm or no to re-enter.');

  _speechToText.listen(
    onResult: (result) {
      String spokenText = result.recognizedWords.toLowerCase();
      if (spokenText.contains('ok')) {
        // Call signUp function with the email
        _signUp(_typedEmail);
      } else if (spokenText.contains('no')) {
        setState(() {
          _typedEmail = '';
          _emailController.clear();
        });
        _startListeningForEmail();
      }
    },
  );
}


  void _signUp(String email) async {
  String email = _emailController.text+"@gmail.com";
  String password = '''$email!12345''';


  try {
    User? user = await _auth.signupWithEmailAndPassword(email, password);

    if (user != null) {
      print("User Created Successfully");
       ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('User Registration Successed'),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
      SecureStorage().saveCredentials(email, password).then((value) => print("Email and password saved in secure storage")).onError((error, stackTrace) => print(error));
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      //  ScaffoldMessenger.of(context).showSnackBar(
      //                                       const SnackBar(
      //                                         content: Text('User Register Failed'),
      //                                         backgroundColor: Colors.red,
      //                                         duration: Duration(seconds: 3),
      //                                       ),
      //                                     );
      print("User Register Failed");
    }
  } catch (e) {
    print("Error registering user: $e");
    // Check if the exception is a FirebaseAuthException
    if (e is FirebaseAuthException) {
      // Display appropriate error message based on the error code
      if (e.code == 'email-already-in-use') {
         ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('The email address is already in use.'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
        print("The email address is already in use.");
      } else if (e.code == 'weak-password') {
         ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('The password provided is too weak.'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
        print("The password provided is too weak.");
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('An unknown error occurred.'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
        print("An unknown error occurred.");
      }
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('An unknown error occurred.'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
      print("An unknown error occurred.");
    }
  }
}

}


class ListingButtons extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPressed;
  final double iconSize;
  final double textSize;

  const ListingButtons({
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
        padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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



