import 'package:flutter/material.dart';
import 'interests_screen.dart';
import 'doc_upload.dart';
// Import any other screens or utilities you need here

class Screen5 extends StatefulWidget {
  const Screen5({Key? key}) : super(key: key);

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  double progress = 0.4; // Assuming this is the next step's progress
  List<String> selectedAffiliations = [];
  String? selectedLanguage;
  int currentScreenIndex = 5; // Assuming Screen5 is the fifth screen
  int totalScreens = 5;
  void updateProgress() {
    setState(() {
      progress =
          (currentScreenIndex - 3) / totalScreens; // Adjust formula as needed
    });
  }

  Widget _buildCheckboxListTile(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: selectedAffiliations.contains(title),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            selectedAffiliations.add(title);
          } else {
            selectedAffiliations.remove(title);
          }
        });
      },
    );
  }

  Widget _buildRadioListTile(String title) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedLanguage,
      onChanged: (String? value) {
        setState(() {
          selectedLanguage = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Know more about yourself'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 242, 74, 2)),
              backgroundColor: Color.fromARGB(255, 39, 38, 38),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mention your Affiliations?*',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCheckboxListTile('Affiliation 1'),
            _buildCheckboxListTile('Affiliation 2'),
            _buildCheckboxListTile('Affiliation 3'),
            _buildCheckboxListTile('Affiliation 4'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            const Text(
              'What language do you prefer?*',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRadioListTile('Marathi'),
            _buildRadioListTile('Telugu'),
            _buildRadioListTile('Tamil'),
            _buildRadioListTile('English'),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DocUploadScreen()),
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
