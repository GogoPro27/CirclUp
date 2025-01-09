import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CameraPage extends StatelessWidget {
  final VoidCallback onPhotoCaptured;

  const CameraPage({Key? key, required this.onPhotoCaptured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.grey),
            onPressed: null, // Placeholder for flash functionality
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_android, color: Colors.grey),
            onPressed: null, // Placeholder for switching cameras
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/camera_photo.jpg', // Ensure this is added to pubspec.yaml
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onPhotoCaptured(); // Notify MatchPage of the photo capture
              Navigator.of(context).pop(); // Return to MatchPage
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}