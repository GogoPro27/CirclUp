import 'dart:async';
import 'package:circl_up_app/screens/success_page.dart';
import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  int _counter = 1; // start with 1/3

  @override
  void initState() {
    super.initState();

    // Simulate waiting for other users uploading (2 seconds each step)
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_counter < 3) {
        setState(() {
          _counter++;
        });
      } else {
        timer.cancel();
        // Wait half a second then navigate to success page
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SuccessPage()),
          );
          // 👆 make sure you define this route in MaterialApp
        });
      }
    });
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
                "Waiting for all participants to take the picture...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Users list (same as MatchPage)
              _buildUserTile(
                  "Samantha Phil", "assets/samantha_picture.png", true),
              _buildUserTile("John Doe", "assets/john_picture.png", true),
              const SizedBox(height: 30),

              // Only group chat button (no take photo)
              _buildCircleButton(Icons.chat_bubble, "Group chat", () {
                // TODO: implement group chat
              }),

              const Spacer(),

              // Counter text
              Text(
                "$_counter/3 uploaded",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reuse the same user tile widget
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

  // Reuse circle button widget
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
