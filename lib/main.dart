import 'package:flutter/material.dart';
import 'package:agent_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: avoid_print
  print('Initializing Firebase...');
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA403R8RfxhWqelKXiljfCwVfZwudFBDT0',
      appId: '1:68286635748:android:e2483e89d8bfbd75e516f1',
      messagingSenderId: '68286635748',
      projectId: 'agent-1-c49a7',
      // Optional for Firebase Storage
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/t2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with transparency
          Center(
            child: Container(
              padding: const EdgeInsets.all(80.0),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Replace this Text widget with an Image widget

                  Transform.translate(
                    offset: const Offset(0.0, -10.0),
                    child: Image.asset(
                      "assets/images/agent.png", // Replace with your image's path
                      width: 200, // Set the width to fit your design
                      height: 200, // Set the height to fit your design
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  const Text(
                    "Get connected for commissions!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 84.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 65.0, vertical: 12.0),
                      backgroundColor: const Color.fromARGB(255, 233, 32, 1),
                      foregroundColor: Colors.white,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Sets a smaller border radius
                      ),
                    ),
                    child: const Text(
                      "Get Started!",
                      style: TextStyle(fontSize: 15.02),
                    ),
                  ),
                  // Terms of Use and Privacy Policy
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text(
                      "By continuing, you agree to Agent App's Terms of Use. Read our Privacy Policy.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
