import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  Future<void> _takePhoto(BuildContext context) async {
    final picker = ImagePicker();

    // Request camera + storage permissions
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (!cameraStatus.isGranted || !storageStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera or storage permission denied")),
      );
      return;
    }

    // Open camera
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    try {
      // Path: /storage/emulated/0/Pictures/matched_pictures/
      final Directory extDir =
      Directory("/storage/emulated/0/Pictures/matched_pictures");

      if (!(await extDir.exists())) {
        await extDir.create(recursive: true);
      }

      // Unique name with timestamp
      final String fileName =
          "match_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}${path.extension(pickedFile.path)}";

      final String newPath = path.join(extDir.path, fileName);

      // Copy the photo
      final File newImage = await File(pickedFile.path).copy(newPath);

      // Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Photo saved in Gallery: ${newImage.path}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving photo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Logo Circle
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/Cupp_pair.png"),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "You have been\n",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "CIRCL", style: TextStyle(color: Colors.orange)),
                    TextSpan(text: "’d", style: TextStyle(color: Colors.black)),
                    TextSpan(text: " UP", style: TextStyle(color: Colors.orange)),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Take a picture with the following people to receive your points!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Users list
              _buildUserTile(
                  "Samantha Phil", "assets/samantha_picture.png", true),
              _buildUserTile("John Doe", "assets/john_picture.png", true),
              const SizedBox(height: 30),

              // Row of buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleButton(Icons.chat_bubble, "Group chat", () {
                    // TODO: implement group chat navigation
                  }),
                  const SizedBox(width: 30),
                  _buildCircleButton(Icons.photo_camera, "Take Photo", () {
                    _takePhoto(context);
                  }),
                ],
              ),

              const Spacer(),

              // Reward text
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "100 ",
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: "CIRCLES",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // User row widget
  Widget _buildUserTile(String name, String imagePath, bool online) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 25,
              ),
              if (online)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Text(name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Orange round button with label
  Widget _buildCircleButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.orange.withOpacity(0.8),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
