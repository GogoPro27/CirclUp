import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class YourProfileScreen extends StatelessWidget {
  const YourProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((user) => user.name == "Nidzo Aerodrom");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Your Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Photo Section
            // Cover Photo and Profile Picture Section
            // Cover Photo and Profile Picture Section
            Stack(
              clipBehavior: Clip.none, // Ensure no clipping
              children: [
                // Cover Photo
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(user.coverPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Pen Icon for Editing Cover Photo
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        // Handle edit cover photo action
                      },
                    ),
                  ),
                ),
                // Profile Picture
                Positioned(
                  bottom: -50, // Place profile picture slightly below cover photo
                  left: MediaQuery.of(context).size.width / 2 - 60,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white, // Outer white border
                    child: CircleAvatar(
                      radius: 56, // Inner actual profile picture
                      backgroundImage: AssetImage(user.profilePicture),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80), // Space below profile picture

            // User Info Section
            Center(
              child: Column(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "MZT", // Example text for additional tag
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Details Section with Narrow Width and Stacked Layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStackedProfileDetail("Name", user.name),
                  const SizedBox(height: 16),
                  _buildStackedProfileDetail("Phone Number", user.phoneNumber, actionText: "Change"),
                  const SizedBox(height: 16),
                  _buildStackedProfileDetail("Email", user.email),
                  const SizedBox(height: 16),
                  _buildStackedProfileDetail(
                    "DOB",
                    "${user.dateOfBirth.day}/${user.dateOfBirth.month}/${user.dateOfBirth.year}",
                  ),
                  const SizedBox(height: 16),
                  _buildStackedDropdownProfileDetail("Gender", user.gender),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Active index for "Profile"
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/'); // Navigate to Home
              break;
            case 1:
              Navigator.pushNamed(context, '/rewards'); // Navigate to Rewards
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications'); // Navigate to Notifications
              break;
            case 3:
            // Stay on the Profile screen
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildStackedProfileDetail(String label, String value, {String? actionText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (actionText != null)
              TextButton(
                onPressed: () {
                  // Add logic for action, like changing phone number
                },
                child: Text(
                  actionText,
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildStackedDropdownProfileDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
