import 'package:flutter/material.dart';

class GroupChatPage extends StatelessWidget {
  const GroupChatPage({Key? key}) : super(key: key);

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
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'CirclUp Group',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            '3 members',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildChatBubble(
                  name: 'John Doe',
                  message: "What's up guys? Where we at?",
                  isMe: false,
                  avatar: 'assets/john_picture.png',
                ),
                _buildChatBubble(
                  name: 'You',
                  message: 'YOO\nI am right at the bar, lets meet here and have a drink!',
                  isMe: true,
                ),
                _buildChatBubble(
                  name: 'John Doe',
                  message: 'Sounds good to me\n@Samantha u there? 😁',
                  isMe: false,
                  avatar: 'assets/john_picture.png',
                ),
                _buildChatBubble(
                  name: 'Samantha Phil',
                  message: 'Woah, hi guys!\nI’ll be at the bar in 5, I’ll text u from there.',
                  isMe: false,
                  avatar: 'assets/samantha_picture.png',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required String name,
    required String message,
    required bool isMe,
    String? avatar,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            backgroundImage: AssetImage(avatar!),
          ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isMe ? Colors.orange.shade100 : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: isMe
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isMe ? Colors.black : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: null, // Disabled for MVP
            icon: const Icon(Icons.attachment, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              enabled: false, // Disabled for MVP
              decoration: InputDecoration(
                hintText: 'Write a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            onPressed: null, // Disabled for MVP
            icon: const Icon(Icons.mic, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}