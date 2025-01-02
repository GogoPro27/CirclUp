import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/user.dart';
import '../widgets/navigation_bar.dart';
import 'favorites_screen.dart';
import 'friends_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = mockUsers[0]; // Use the first user as the profile demo user

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
                  bottom: -40,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(user.profilePicture),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50), // Space below profile picture
            // User Details (Name, Bio, Coins)
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
                const SizedBox(height: 10),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Friends Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Friends Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendsScreen(user: user),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.people, color: Colors.black),
                        const SizedBox(width: 8),
                        Text("Friends (${user.friends.length})"),
                      ],
                    ),
                  ),
                ),
                // Favorites Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Favorites Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen(user: user),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite, color: Colors.red),
                        const SizedBox(width: 8),
                        Text("Favorites (${user.favoritePlaces.length})"),
                      ],
                    ),
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
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
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
