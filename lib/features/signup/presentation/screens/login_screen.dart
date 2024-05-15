import 'package:blindbnking/config/app_values.dart';
import 'package:blindbnking/core/presentation/widgets/buttons/primary_button.dart';
import 'package:blindbnking/core/service/secureStorage/secure_storage.dart';
import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/register/domain/service/auth_service.dart';
import 'package:blindbnking/features/register/presentation/screens/blind_register.dart';
import 'package:blindbnking/features/register/presentation/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool is_authenticated = false;
  final TextToSpeech textToSpeech = TextToSpeech();
  final storage = new FlutterSecureStorage();

  final FirebaseAuthService _auth = FirebaseAuthService();
  final LocalAuthentication _localAuth = LocalAuthentication();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Login',
          style: TextStyle(
            fontSize: 24.0,
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
                      'Login',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
              PrimaryButton(text: "Login", onPressed: _login),
              
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text(
                  'Not account? Please sign up and create account',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 50.0),
              TextButton(
                  onPressed: ()async {
                    final bool canAuthenticate = await _localAuth.canCheckBiometrics;
                    print(canAuthenticate);

                    if (canAuthenticate) {
                      try {
                        final bool didAuthenticate = await _localAuth.authenticate(localizedReason: "Please Authenticate For Login",
                          options: const AuthenticationOptions(
                            biometricOnly: true
                          )
                          );
                          setState(() {
                            is_authenticated = didAuthenticate;
                          });

                          if (didAuthenticate) {
                            final String mail = await SecureStorage().getMail();
                            final String pass = await SecureStorage().getPass();
                            
                            print(mail);
                            print(pass);
                            
                            if (mail == "failed to get email" || pass == "failed to get password"){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => BlindRegisterScreen()));
                            }
                            else {
                              _emailController.text = mail;
                              _passwordController.text = pass;
                            
                              User? user = await _auth.signinWithEmailAndPassword(mail, pass);
                            
                              if (user != null){
                                ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Login successed'),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                // Convert text to speech
                                textToSpeech.speak('Successfully Login');
                                // Stop speech
                                textToSpeech.stop();
                                Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Login Failed. Try Again...'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                              }
                            
                            }
                          }

                          else {
                             print("login failed");
                          }
                      } catch (e){
                        print(e);
                      }
                      
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fingerprint Not Support For Your Device'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
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
                        child: const Icon(Icons.fingerprint, size: 100.0, color: Colors.blue),
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
  void _login() async{
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signinWithEmailAndPassword(email, password);

    if (user != null){
      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login successed'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
      Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login Failed. Try Again...'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
    }

  }
}