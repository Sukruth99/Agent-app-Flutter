// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agent_app/screens/otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  String? _idToken;

  @override
  void dispose() {
    _nameTextController.dispose();
    _phoneNumberTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Sign up with Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Text(
                      'Get chatting with friends and family today by signing up for our chat app!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 72.0),
                    _buildTextFormField(
                        'Your name*', 'Username', _nameTextController),
                    _buildTextFormField('Your Phone Number*',
                        '+01 394-456-4654', _phoneNumberTextController),
                    _buildTextFormField('Your email', 'username@gmail.com',
                        _emailTextController),
                    _buildPasswordField(), // Added password field
                    _buildLocationField(context),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: _createAccount,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.red, width: 3.75), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                      ),
                      child: const Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (otpSent) // Check if OTP has been sent
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'OTP code has been sent to your phone number.',
                          style: TextStyle(
                            color:
                                Colors.green, // Customize the color if needed
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 45.0),
      child: TextFormField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 45.0),
      child: TextFormField(
        controller: _passwordTextController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Your password*',
          hintText: 'Enter your password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Location',
          hintText: 'Enter Location',
          suffixIcon: Icon(Icons.location_pin),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  bool otpSent = false;

  void _createAccount() async {
    String phoneNumber = _phoneNumberTextController.text.trim();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print('Automatic verification successful');

          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          String? idToken =
              await userCredential.user?.getIdToken(); // Get the ID token

          if (idToken != null) {
            print('ID Token: $idToken');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  phoneNumber: phoneNumber,
                  verificationId: '', // Pass verificationId here
                ),
              ),
            );
          } else {
            print('Error getting ID Token');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone verification failed: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Phone verification failed: ${e.message}'),
              duration: const Duration(seconds: 4),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('OTP code sent');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId, // Pass verificationId here
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Verification timeout');
        },
      );
    } catch (e) {
      print('Error verifying phone number: $e');
    }
  }
}
