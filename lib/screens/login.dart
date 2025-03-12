import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter/gestures.dart';
import 'signup.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);
  void _loginWithPhoneNumber(BuildContext context, String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Firebase automatically handles the verification and signs in the user.
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'user-not-found') {
          // No user found, redirect to sign-up page.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // The code has been sent, navigate to the OTPScreen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto retrieval timeout, you can prompt the user to manually enter the code.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 120.0),
                const Text(
                  'Login to Agent App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Welcome back! Sign in using your social account or email to continue us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                const SizedBox(height: 48.0),
                _buildSocialMediaLogin(),
                const SizedBox(height: 24.0),
                _buildPhoneField(), // Changed to phone field
                const SizedBox(height: 24.0),
                _buildLoginButton(context),
                _buildSignUpOption(context),
                _buildTermsText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaLogin() {
    return Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          _buildSocialIconButton(Bootstrap.facebook, () {
            // Implement Facebook login logic
          }),
          const SizedBox(width: 12.0),
          _buildSocialIconButton(Bootstrap.google, () {
            // Implement Google login logic
          }),
          const SizedBox(width: 12.0),
          _buildSocialIconButton(Bootstrap.apple, () {
            // Implement Apple login logic
          }),
        ]),
        const SizedBox(height: 24.0),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Divider(color: Colors.grey[400], thickness: 1),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildSocialIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: Icon(
          icon,
          size: 36.0,
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: _phoneController, // Assigning the TextEditingController
        keyboardType: TextInputType.phone, // Correct for phone number input
        decoration: InputDecoration(
          hintText: 'Phone number', // Placeholder text
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                32.0), // Rounded corners for the input field
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0), // Grey border when field is enabled
            borderRadius: BorderRadius.circular(32.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.grey,
                width:
                    2.0), // Slightly thicker grey border when field is focused
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: const Color.fromARGB(255, 233, 32, 1),
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        elevation: 4.0,
        child: MaterialButton(
          onPressed: () {
            print("Entered phone number: '${_phoneController.text}'");
            if (_phoneController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter a phone number")),
              );
              return;
            }
            _loginWithPhoneNumber(context, _phoneController.text.trim());
          },
          minWidth: .0,
          height: 52.0,
          child: const Text(
            'Log In',
            style: TextStyle(fontSize: 16.02, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpOption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14.0),
          children: <TextSpan>[
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign up',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        'By continuing, you agree to Agent App\'s Terms of Use. Read our Privacy Policy.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}
