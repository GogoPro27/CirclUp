import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/user.dart';
import '../widgets/navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = mockUsers[0]; // Use mockUsers[0] as the main demo user

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Photo and Profile Picture
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover Photo
                Image.asset(
                  user.coverPhoto,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Profile Picture
                Positioned(
                  bottom: -50, // Adjusted to ensure full visibility
                  left: MediaQuery.of(context).size.width / 2 - 60,
                  child: GestureDetector(
                    onTap: () {
                      // Fullscreen profile picture dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  user.profilePicture,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 60, // Increased size for better visibility
                      backgroundImage: AssetImage(user.profilePicture),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.green, // Online status indicator
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70), // Adjusted to provide more spacing
            // User Details (Name, Bio, Location, and Coins)
            Column(
              children: [
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  user.bio,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "🏀 MZT • Skopje, N.Macedonia", // Replace with dynamic location if needed
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                // Coins Count
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${user.coins} 🪙",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Friends and Favorites Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Friends Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Friends Screen (to be implemented)
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.people, size: 28, color: Colors.black),
                      const SizedBox(height: 4),
                      Text("Friends (${user.friends.length})"),
                    ],
                  ),
                ),
                // Favorites Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Favorites Screen (to be implemented)
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.favorite, size: 28, color: Colors.red),
                      const SizedBox(height: 4),
                      Text("Favorites (${user.favoritePlaces.length})"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Grid of Posts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1, // Square aspect ratio
                ),
                itemCount: user.posts.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          user.posts[index],
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Row(
                            children: const [
                              Icon(Icons.favorite, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "1k", // Replace with dynamic likes if needed
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0:
            // Stay on the home screen
              break;
            case 1:
              Navigator.pushNamed(context, '/rewards');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
