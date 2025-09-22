import 'package:flutter/material.dart';
import '../data/data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read logic (optional)
            },
            child: const Text(
              "Mark all as read",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mockNotifications.length,
        itemBuilder: (context, index) {
          final notification = mockNotifications[index];
          final backgroundColor = index % 2 == 0
              ? Colors.grey.shade100
              : Colors.white;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: notification.isActionable ? 2 : 0,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture
                  if (notification.profilePicture != null)
                    CircleAvatar(
                      backgroundImage: AssetImage(notification.profilePicture!),
                    ),

                  if (notification.profilePicture != null)
                    const SizedBox(width: 12),

                  // Main content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.message,
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(notification.timestamp,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),

                        if (notification.isActionable) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Accept"),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Decline"),
                              ),
                            ],
                          ),
                        ] else if (notification.isSponsored) ...[
                          const SizedBox(height: 8),
                          const Text(
                            "SPONSORED",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
