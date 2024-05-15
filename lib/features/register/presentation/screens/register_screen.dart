import 'package:blindbnking/config/app_values.dart';
import 'package:blindbnking/core/presentation/widgets/buttons/primary_button.dart';
import 'package:blindbnking/core/service/secureStorage/secure_storage.dart';
import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/register/domain/service/auth_service.dart';
import 'package:blindbnking/features/register/presentation/screens/blind_register.dart';
import 'package:blindbnking/features/signup/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextToSpeech textToSpeech = TextToSpeech();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 70.0,top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance, size: 50.0, color: Colors.blue),
                    SizedBox(width: AppValues.padding),
                    Text(
                      'Register',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                controller: _emailController,
              ),
              const SizedBox(height: AppValues.padding),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: AppValues.padding),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: AppValues.padding),
              PrimaryButton(text: "Sign In", onPressed: _signUp),
              
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Already Have an Account? Login Here',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                    // Convert text to speech
                    textToSpeech.speak('Registration For Blind Users');
                    // Stop speech
                    textToSpeech.stop();
                    Navigator.push(context,MaterialPageRoute(builder: (context) => BlindRegisterScreen()));
                   
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2.0),
                        ),
                        child: const Icon(Icons.mic, size: 100.0, color: Colors.blue),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'For Blind Users',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
  String email = _emailController.text;
  String password = _passwordController.text;
  String confirmPassword = _confirmPasswordController.text;

  if (password != confirmPassword) {
    // Passwords do not match
     ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Passwords do not match'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
    print("Passwords do not match");
    return;
  }

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
       ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('User Register Failed'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
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
