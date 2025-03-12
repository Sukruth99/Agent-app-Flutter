import 'package:flutter/material.dart';
import 'affiliations_screen.dart'; // Import Screen5.dart here

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  double progress = 0.2; // Initial progress for Screen 4
  int currentScreenIndex = 4; // Initial screen index
  int totalScreens = 5;
  List<String> selectedInterests = [];

  void updateProgress() {
    setState(() {
      progress = (currentScreenIndex - 3) /
          totalScreens; // Calculate progress dynamically
    });
  }

  Widget _buildInterestButton(BuildContext context, String interestName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedInterests.contains(interestName)) {
            selectedInterests.remove(interestName);
          } else {
            selectedInterests.add(interestName);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            interestName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: selectedInterests.contains(interestName)
                  ? Colors.orange
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mention your Interests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Mention your Interests',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select your interests so we can show best to you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress, // Progress value based on screen navigation
              minHeight: 7,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 242, 74, 2),
              ),
              backgroundColor: Color.fromARGB(255, 39, 38, 38),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                _buildInterestButton(context, 'Cab'),
                _buildInterestButton(context, 'Hiking'),
                _buildInterestButton(context, 'Reservations'),
                _buildInterestButton(context, 'Restaurants'),
                _buildInterestButton(context, 'Photography'),
                _buildInterestButton(context, 'Baggages'),
                _buildInterestButton(context, 'Cafeteria'),
                _buildInterestButton(context, 'Bars'),
                _buildInterestButton(context, 'Mountains'),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Screen5()),
                ).then((value) {
                  if (value != null && value is double) {
                    currentScreenIndex++; // Increment screen index
                    updateProgress(); // Update progress
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.red, width: 3.75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
