import 'package:flutter/material.dart';
import '../models/user.dart';
import 'add_friends_screen.dart';

class FriendsScreen extends StatelessWidget {
  final User user;

  const FriendsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: ListView.builder(
        itemCount: user.friends.length,
        itemBuilder: (context, index) {
          final friend = user.friends[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(friend.profilePicture),
            ),
            title: Text(friend.name),
            subtitle: Text(friend.bio),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFriendsScreen(user: user), // Updated screen name
            ),
          );
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Friends Screen", // Updated label
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AddFriendsMockScreen extends StatelessWidget {
  const AddFriendsMockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Friends"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          "This is a mock Add Friends screen.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
