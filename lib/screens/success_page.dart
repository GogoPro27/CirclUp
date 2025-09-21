import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final List<Map<String, dynamic>> matchedUsers;

  const SuccessPage({Key? key, required this.matchedUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/Cupp_pair.png", fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Great discomfort!\nYou have received",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "100 ",
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: "circles",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text("with :", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),


              // Matched users
              ...matchedUsers.map((u) => _buildUserTile(
                u["name"] ?? "Unknown",
                u["profilePicture"] ?? "assets/default.png",
              )),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildUserTile(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 25,
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.add_circle_outline, color: Colors.black54),
        ],
      ),
    );
  }
}
