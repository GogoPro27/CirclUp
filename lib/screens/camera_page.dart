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
            onPressed: null,
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_android, color: Colors.grey),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/camera_photo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onPhotoCaptured();
              Navigator.of(context).pop();
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