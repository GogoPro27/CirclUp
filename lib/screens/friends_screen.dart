import 'package:flutter/material.dart';
import '../models/user.dart';

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
    );
  }
}
