import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData() async {
    return await FirebaseFirestore.instance.collection("Users").doc("user1").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/edit');
            },
          ),
        ],
      ),

      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User not found"));
          }

          final userData = snapshot.data!.data()!;
          final String name = userData['name'] ?? '';
          final String bio = userData['bio'] ?? '';
          final int coins = userData['coins'] ?? 0;
          final String coverPhoto = userData['coverPhoto'] ?? 'assets/mzt.png';
          final String profilePicture = userData['profilePicture'] ?? 'assets/nidzo_picture.png';
          final List<dynamic> friends = userData['friends'] ?? [];
          final List<dynamic> favoritePlaces = userData['favoritePlaces'] ?? [];
          final List<dynamic> posts = userData['posts'] ?? [];

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Cover Photo
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(coverPhoto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Profile Picture
                        Positioned(
                          bottom: -50,
                          left: MediaQuery.of(context).size.width / 2 - 50,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(profilePicture),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),

                    // User Details
                    Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          bio,
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
                            "$coins 🪙",
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/friends');
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
                                Text("Friends (${friends.length})"),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/favorites');
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
                                Text("Favorites (${favoritePlaces.length})"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Posts grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  posts[index],
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Row(
                                    children: [
                                      Icon(Icons.favorite,
                                          color: Colors.white, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        "1k", // Example like count
                                        style: TextStyle(color: Colors.white, fontSize: 14),
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
            ],
          );
        },
      ),
    );
  }
}
