import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'update_payment.dart';

class DocUploadScreen extends StatefulWidget {
  const DocUploadScreen({Key? key}) : super(key: key);

  @override
  _DocUploadScreenState createState() => _DocUploadScreenState();
}

class _DocUploadScreenState extends State<DocUploadScreen> {
  String? _typeOfDoc;
  Uint8List? _imageData; // Changed from File to Uint8List
  final ImagePicker _picker = ImagePicker();

  void _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  void _openGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Upload Authorization Document',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 32),
              const Text(
                'Upload a document like your Driver\'s License or PAN card so we can verify your identity.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Type of Document',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: _typeOfDoc,
                items: <String>['PAN', 'Driver\'s License']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _typeOfDoc = newValue;
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _openCamera,
                    iconSize: 40,
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_library),
                    onPressed: _openGallery,
                    iconSize: 40,
                  ),
                ],
              ),
              if (_imageData != null) ...[
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Image.memory(_imageData!,
                        height: 200, width: double.infinity, fit: BoxFit.cover),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(color: Colors.black.withOpacity(0)),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Implement the upload functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdatePaymentScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Upload and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
