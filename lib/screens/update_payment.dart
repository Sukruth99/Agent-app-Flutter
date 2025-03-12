import 'package:flutter/material.dart';
import 'thank_you.dart';

class UpdatePaymentScreen extends StatefulWidget {
  const UpdatePaymentScreen({Key? key}) : super(key: key);

  @override
  _UpdatePaymentScreenState createState() => _UpdatePaymentScreenState();
}

class _UpdatePaymentScreenState extends State<UpdatePaymentScreen> {
  String? _typeOfPayment;
  List<String> _paymentDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a new Bank Activity method',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Simplest way for our users in palm of their hands!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // Add your options for bank, cash, UPI here
              ListTile(
                title: const Text('Add new bank account'),
                leading: Radio<String>(
                  value: 'Bank',
                  groupValue: _typeOfPayment,
                  onChanged: (value) {
                    setState(() {
                      _typeOfPayment = value;
                      _paymentDetails.clear();
                      _paymentDetails.add('Bank account details...');
                      // Add your logic to prompt for bank account details here
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Cash'),
                leading: Radio<String>(
                  value: 'Cash',
                  groupValue: _typeOfPayment,
                  onChanged: (value) {
                    setState(() {
                      _typeOfPayment = value;
                      _paymentDetails = [];
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('UPI'),
                leading: Radio<String>(
                  value: 'UPI',
                  groupValue: _typeOfPayment,
                  onChanged: (value) {
                    setState(() {
                      _typeOfPayment = value;
                      _paymentDetails.clear();
                      _paymentDetails.add('UPI details...');
                      // Add your logic to prompt for UPI details here
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Confirm and continue'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.red, width: 3.75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThankYouScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
