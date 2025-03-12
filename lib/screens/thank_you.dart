import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Thank you we found so much about you',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Thank you for signing up in an app now It will be visible in next 24 hours.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Text(
              "It's time to take your beautiful photo",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/thanks_img.jpg", // Replace with your asset name
                  height: 250, // Adjust the size accordingly
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ElevatedButton(
                onPressed: () {
                  // Define the action when the button is pressed
                },
                child: Text('Continue'),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
