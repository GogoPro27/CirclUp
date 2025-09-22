import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circl_up_app/screens/success_page.dart';
import 'package:circl_up_app/screens/group_chat_page.dart';
import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  final List<Map<String, dynamic>> matchedUsers;

  const WaitingPage({Key? key, required this.matchedUsers}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  int _counter = 1;
  late int totalParticipants;

  @override
  void initState() {
    super.initState();
    totalParticipants = widget.matchedUsers.length + 1;

    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_counter < totalParticipants) {
        setState(() {
          _counter++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () async {
          await _addCoinsToParticipants();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SuccessPage(matchedUsers: widget.matchedUsers),
            ),
          );
        });
      }
    });
  }

  Future<void> _addCoinsToParticipants() async {
    final firestore = FirebaseFirestore.instance;

    // Add coins to Nidzo Aerodrom
    await firestore.collection("Users").doc("user1").update({
      "coins": FieldValue.increment(100),
    });

    // Add coins to matched users
    for (final user in widget.matchedUsers) {
      final docId = user["id"];
      if (docId != null) {
        await firestore.collection("Users").doc(docId).update({
          "coins": FieldValue.increment(100),
        });
      }
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

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

              const Text(
                "Waiting for all participants to take the picture...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              Column(
                children: widget.matchedUsers
                    .map((u) => _buildUserTile(
                  u["name"] ?? "Unknown",
                  u["profilePicture"] ?? "assets/default.png",
                  true,
                ))
                    .toList(),
              ),
              const SizedBox(height: 30),

              // ✅ Navigate to GroupChatPage
              _buildCircleButton(Icons.chat_bubble, "Group chat", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GroupChatPage()),
                );
              }),

              const Spacer(),

              Text(
                "$_counter/$totalParticipants uploaded",
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
