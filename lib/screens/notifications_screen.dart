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
              ? Colors.grey.shade100 // Light grey for even-indexed notifications
              : Colors.white; // White for odd-indexed notifications

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: notification.isActionable ? 2 : 0,
            color: backgroundColor,
            child: ListTile(
              leading: notification.profilePicture != null
                  ? CircleAvatar(
                      backgroundImage: AssetImage(notification.profilePicture!),
                    )
                  : null,
              title: Text(notification.message),
              subtitle: Text(notification.timestamp),
              trailing: notification.isActionable
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Accept action (MVP - no functionality)
                          },
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
                          onPressed: () {
                            // Decline action (MVP - no functionality)
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Decline"),
                        ),
                      ],
                    )
                  : notification.isSponsored
                      ? const Text(
                          "SPONSORED",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      : const Icon(Icons.more_vert, color: Colors.grey),
              onTap: () {
                // Optional: Handle notification click
              },
            ),
          );
        },
      ),
    );
  }
}