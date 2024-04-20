import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_collage_flutter/collage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile>? _imageFiles; // Store picked images

  void _pickImagesAndNavigate() async {
    await _pickImages();
    _navigateToDisplayPhotosScreen();
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(); // Pick multiple images
    setState(() {
      _imageFiles = pickedImages;
    });
  }

  void _navigateToDisplayPhotosScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPhotosScreen(selectedPhotos: _imageFiles),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Collage App'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _pickImagesAndNavigate();
          }, // Call _pickImages method when button is pressed
          child: const Text('Pick Images'),
        ),
      ),
    );
  }
}
