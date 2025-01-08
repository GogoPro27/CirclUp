import 'package:flutter/material.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular logo
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange,
            child: Text(
              'C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Main heading
          const Text(
            'You have been\nCIRCL’d UP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Subheading
          const Text(
            'Take a picture with the following people to receive your points!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // List of users
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/samantha_picture.png'),
            ),
            title: Text("Samantha Phil"),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/john_picture.png'),
            ),
            title: Text("John Doe"),
          ),
          const SizedBox(height: 40),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Group Chat Button
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/group-chat');
                    },
                    icon: const Icon(Icons.chat_bubble),
                    label: const Text("Group Chat"),
                  ),
                ],
              ),
              // Take Photo Button
              const Column(
                children: [
                  IconButton(
                    onPressed: null, // Disabled for now
                    icon: Icon(Icons.camera_alt, color: Colors.orange),
                  ),
                  Text("Take Photo"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Circles points
          const Text(
            '100 CIRCLES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}