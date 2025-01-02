import 'package:flutter/material.dart';
import '../models/user.dart';

class FavoritesScreen extends StatelessWidget {
  final User user;

  const FavoritesScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: user.favoritePlaces.length,
        itemBuilder: (context, index) {
          final place = user.favoritePlaces[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(place.logo),
            ),
            title: Text(place.name),
            subtitle: Text(place.description),
          );
        },
      ),
    );
  }
}
